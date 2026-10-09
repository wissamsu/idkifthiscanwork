package com.wissam.Applier.Security;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.server.resource.web.BearerTokenAuthenticationEntryPoint;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.DelegatingAuthenticationEntryPoint;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.util.matcher.MediaTypeRequestMatcher;
import org.springframework.security.web.util.matcher.RequestHeaderRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import lombok.RequiredArgsConstructor;

/**
 * SecurityConfig
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

  private final KeycloakOidcUserEndpoint OidcUserService;

  @Bean
  SecurityFilterChain filter(HttpSecurity http) {
    http
        .csrf(csrf -> csrf.disable())
        .cors(cors -> cors.configurationSource(corsConfigurationSource()))
        .authorizeHttpRequests(auth -> auth
            .requestMatchers("/error", "/.well-known/**").permitAll()
            .anyRequest().authenticated())
        .oauth2ResourceServer(oath2 -> oath2.jwt(Customizer.withDefaults()))
        .oauth2Login(login -> login.userInfoEndpoint(userinfo -> userinfo.oidcUserService(OidcUserService)))
        .exceptionHandling(ex -> ex
            .authenticationEntryPoint(authenticationEntryPoint())
            .accessDeniedPage("/403"));
    return http.build();
  }

  @Bean
  AuthenticationEntryPoint authenticationEntryPoint() {
    return DelegatingAuthenticationEntryPoint.builder()
        .defaultEntryPoint(new BearerTokenAuthenticationEntryPoint())
        .addEntryPointFor(new BearerTokenAuthenticationEntryPoint(),
            new RequestHeaderRequestMatcher(HttpHeaders.AUTHORIZATION))
        .addEntryPointFor(new LoginUrlAuthenticationEntryPoint("/oauth2/authorization/keycloak"),
            new MediaTypeRequestMatcher(MediaType.TEXT_HTML))
        .build();
  }

  @Bean
  CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration configuration = new CorsConfiguration();
    configuration.setAllowedOrigins(List.of("*"));
    configuration.setAllowedMethods(List.of("*"));
    configuration.setAllowedHeaders(List.of("*"));
    configuration.setAllowCredentials(true);
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", configuration);
    return source;
  }

}
