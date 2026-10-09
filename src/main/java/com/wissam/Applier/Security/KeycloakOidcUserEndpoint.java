package com.wissam.Applier.Security;

import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wissam.Applier.Model.User;
import com.wissam.Applier.Repository.UserRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * KeycloakOidcUserEndpoint
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class KeycloakOidcUserEndpoint extends OidcUserService {

  private final UserRepository userRepository;

    @Transactional
    @Override
  	public OidcUser loadUser(OidcUserRequest userRequest){
      OidcUser oidcUser = super.loadUser(userRequest);

      String email = oidcUser.getEmail();
  if (email != null && userRepository.findByEmail(email).isEmpty()) {
    userRepository.save(User.builder().email(email).build());
    log.info("New user created: {}", email);
  }


      return oidcUser;
    }

}
