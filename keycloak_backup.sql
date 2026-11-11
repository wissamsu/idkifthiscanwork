--
-- PostgreSQL database dump
--

\restrict Sa92Krx22JUjk9xBLtFRIH8W0PuAtIwmZof4WkRCZeNJeNziICj4iBK2NHHYWov

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres_keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres_keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres_keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres_keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres_keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres_keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres_keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres_keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres_keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres_keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres_keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres_keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres_keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres_keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres_keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres_keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres_keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres_keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres_keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres_keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres_keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres_keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres_keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres_keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres_keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres_keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres_keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres_keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres_keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres_keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres_keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres_keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres_keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres_keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres_keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres_keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres_keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres_keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres_keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO postgres_keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres_keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres_keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres_keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres_keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres_keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres_keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres_keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres_keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres_keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres_keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres_keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres_keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres_keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres_keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres_keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres_keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres_keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres_keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres_keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres_keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres_keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres_keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres_keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres_keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres_keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres_keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres_keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres_keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres_keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres_keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres_keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres_keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres_keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres_keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres_keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres_keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres_keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres_keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres_keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres_keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres_keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres_keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres_keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres_keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres_keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres_keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres_keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres_keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
d7d7f66e-52a5-4336-8fd6-1393312815cc	\N	auth-cookie	68d4a947-cff1-493f-8942-868a60f3a7a4	06266cab-15a5-4807-ad2d-801fe6ee875e	2	10	f	\N	\N
71c3f78d-9d46-4019-a534-08b03fd46241	\N	auth-spnego	68d4a947-cff1-493f-8942-868a60f3a7a4	06266cab-15a5-4807-ad2d-801fe6ee875e	3	20	f	\N	\N
98cc8af1-fc59-4773-94e3-450d650719b5	\N	identity-provider-redirector	68d4a947-cff1-493f-8942-868a60f3a7a4	06266cab-15a5-4807-ad2d-801fe6ee875e	2	25	f	\N	\N
684c7f0b-437a-46b4-a109-2ae7350db015	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	06266cab-15a5-4807-ad2d-801fe6ee875e	2	30	t	d396c7fa-5ad7-4e7a-b053-fc964df2bfa3	\N
f21035fc-099c-4483-b59c-24c429562696	\N	auth-username-password-form	68d4a947-cff1-493f-8942-868a60f3a7a4	d396c7fa-5ad7-4e7a-b053-fc964df2bfa3	0	10	f	\N	\N
058822d0-f0be-4923-a4ef-fadcb55f75c6	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	d396c7fa-5ad7-4e7a-b053-fc964df2bfa3	1	20	t	a367b6cc-1691-4034-bb92-bcf7041ec2ac	\N
ce6acd4e-4c7e-4e5b-95e3-613c896c4ded	\N	conditional-user-configured	68d4a947-cff1-493f-8942-868a60f3a7a4	a367b6cc-1691-4034-bb92-bcf7041ec2ac	0	10	f	\N	\N
85f14647-5b3d-45cd-b284-e3d15b26cea3	\N	auth-otp-form	68d4a947-cff1-493f-8942-868a60f3a7a4	a367b6cc-1691-4034-bb92-bcf7041ec2ac	0	20	f	\N	\N
4607cbc4-d268-42b3-95d8-c257ffb30965	\N	direct-grant-validate-username	68d4a947-cff1-493f-8942-868a60f3a7a4	4d776a13-6822-4604-98cd-e848385b8add	0	10	f	\N	\N
51d25c04-6515-4252-922a-d150391efb4d	\N	direct-grant-validate-password	68d4a947-cff1-493f-8942-868a60f3a7a4	4d776a13-6822-4604-98cd-e848385b8add	0	20	f	\N	\N
9960e394-439b-4adf-811b-bfd719137d38	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	4d776a13-6822-4604-98cd-e848385b8add	1	30	t	7056d64b-1147-47a0-a034-623d9ac21d23	\N
72325e62-8ab5-46b1-a0b5-8b4c732b9542	\N	conditional-user-configured	68d4a947-cff1-493f-8942-868a60f3a7a4	7056d64b-1147-47a0-a034-623d9ac21d23	0	10	f	\N	\N
e519d61d-cffd-4674-aa2c-0a741f0a47b6	\N	direct-grant-validate-otp	68d4a947-cff1-493f-8942-868a60f3a7a4	7056d64b-1147-47a0-a034-623d9ac21d23	0	20	f	\N	\N
a3fd60c6-5403-4782-9216-67d003110db4	\N	registration-page-form	68d4a947-cff1-493f-8942-868a60f3a7a4	cb79672d-8778-4fe4-8da8-34fad42332c3	0	10	t	acad2059-5fa3-41f4-b500-a6cf1bed8764	\N
07308585-484d-4945-987b-0b52c94a9f4c	\N	registration-user-creation	68d4a947-cff1-493f-8942-868a60f3a7a4	acad2059-5fa3-41f4-b500-a6cf1bed8764	0	20	f	\N	\N
e6cda8da-8688-4cc0-b8a6-2b97f4d78762	\N	registration-password-action	68d4a947-cff1-493f-8942-868a60f3a7a4	acad2059-5fa3-41f4-b500-a6cf1bed8764	0	50	f	\N	\N
9851c42c-e430-47af-a736-20211515e62b	\N	registration-recaptcha-action	68d4a947-cff1-493f-8942-868a60f3a7a4	acad2059-5fa3-41f4-b500-a6cf1bed8764	3	60	f	\N	\N
cf11e608-52d5-4bd2-bba0-609b932f2ba1	\N	registration-terms-and-conditions	68d4a947-cff1-493f-8942-868a60f3a7a4	acad2059-5fa3-41f4-b500-a6cf1bed8764	3	70	f	\N	\N
5e4a063f-a5fa-45d9-bc7d-456c34e47e86	\N	reset-credentials-choose-user	68d4a947-cff1-493f-8942-868a60f3a7a4	37d54ee1-5f22-4064-8ca7-90c5699ce205	0	10	f	\N	\N
cff46b91-f2ef-4c98-84ba-2ed8001503f1	\N	reset-credential-email	68d4a947-cff1-493f-8942-868a60f3a7a4	37d54ee1-5f22-4064-8ca7-90c5699ce205	0	20	f	\N	\N
2057b85e-0b20-4c78-9fa9-46dc16b8c878	\N	reset-password	68d4a947-cff1-493f-8942-868a60f3a7a4	37d54ee1-5f22-4064-8ca7-90c5699ce205	0	30	f	\N	\N
11af3b71-25d7-493c-9630-27994d4ed53d	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	37d54ee1-5f22-4064-8ca7-90c5699ce205	1	40	t	bda8e01d-3dc8-4b2d-aa1f-ab5ebe51076a	\N
7473e596-0dfd-44b3-a2c8-1a166edfa6cc	\N	conditional-user-configured	68d4a947-cff1-493f-8942-868a60f3a7a4	bda8e01d-3dc8-4b2d-aa1f-ab5ebe51076a	0	10	f	\N	\N
395bea91-6e6c-46ed-9204-ef7148cbf5cb	\N	reset-otp	68d4a947-cff1-493f-8942-868a60f3a7a4	bda8e01d-3dc8-4b2d-aa1f-ab5ebe51076a	0	20	f	\N	\N
8ae82547-6496-4451-82e5-488e6cbd615d	\N	client-secret	68d4a947-cff1-493f-8942-868a60f3a7a4	ed28a595-5a40-436c-933d-91f8f2b8a64f	2	10	f	\N	\N
e9833a2e-0e5b-435d-bb98-f6b5f6c9e500	\N	client-jwt	68d4a947-cff1-493f-8942-868a60f3a7a4	ed28a595-5a40-436c-933d-91f8f2b8a64f	2	20	f	\N	\N
c8bcf2a7-4ba7-4fbf-a27a-7e25549cff93	\N	client-secret-jwt	68d4a947-cff1-493f-8942-868a60f3a7a4	ed28a595-5a40-436c-933d-91f8f2b8a64f	2	30	f	\N	\N
bb58130a-29d9-4ba5-8a85-5f0e6a0ca995	\N	client-x509	68d4a947-cff1-493f-8942-868a60f3a7a4	ed28a595-5a40-436c-933d-91f8f2b8a64f	2	40	f	\N	\N
e9299d7a-1d26-4c81-a26c-64cfbd8034e3	\N	idp-review-profile	68d4a947-cff1-493f-8942-868a60f3a7a4	8baaeddb-fad8-49d3-99dc-57a2cb9849c9	0	10	f	\N	25a7b377-406d-4af2-bf62-bb687506c2f3
ddd8107d-8607-42be-be6d-5821a38d304c	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	8baaeddb-fad8-49d3-99dc-57a2cb9849c9	0	20	t	967e18f4-430a-420e-98d5-1deeb1f29105	\N
7ac92b59-f86b-4127-a035-d2436645d785	\N	idp-create-user-if-unique	68d4a947-cff1-493f-8942-868a60f3a7a4	967e18f4-430a-420e-98d5-1deeb1f29105	2	10	f	\N	4a78e2b2-1bc8-4860-a33d-5954137df5a0
275fd4c8-bbc2-4986-a3c9-00b702aaeded	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	967e18f4-430a-420e-98d5-1deeb1f29105	2	20	t	fc1a8c9a-ab4d-4d6b-9fb2-1c34ceccefdb	\N
e43b6c95-8753-425e-aa4b-48e5c3ab8e1d	\N	idp-confirm-link	68d4a947-cff1-493f-8942-868a60f3a7a4	fc1a8c9a-ab4d-4d6b-9fb2-1c34ceccefdb	0	10	f	\N	\N
640a1f86-ebb2-4520-a83d-6476217ee9ba	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	fc1a8c9a-ab4d-4d6b-9fb2-1c34ceccefdb	0	20	t	570493ce-8039-4485-bb2b-b5b99f5eb685	\N
151bdf8f-f90c-4abf-adee-4b86516307e3	\N	idp-email-verification	68d4a947-cff1-493f-8942-868a60f3a7a4	570493ce-8039-4485-bb2b-b5b99f5eb685	2	10	f	\N	\N
c77c40f5-c450-4590-ac13-fe98b6ebde80	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	570493ce-8039-4485-bb2b-b5b99f5eb685	2	20	t	681cbc4e-b5b3-4a25-b291-a09b59d1069e	\N
8d20ee11-813c-4dc7-ad75-d8ec551a5d32	\N	idp-username-password-form	68d4a947-cff1-493f-8942-868a60f3a7a4	681cbc4e-b5b3-4a25-b291-a09b59d1069e	0	10	f	\N	\N
194114c3-c80c-4841-a2dc-7f825a197800	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	681cbc4e-b5b3-4a25-b291-a09b59d1069e	1	20	t	fff228ad-c8d1-41bd-91f1-4d5ea86ac0f5	\N
f87efc05-ca5c-477d-acd5-f14f95565574	\N	conditional-user-configured	68d4a947-cff1-493f-8942-868a60f3a7a4	fff228ad-c8d1-41bd-91f1-4d5ea86ac0f5	0	10	f	\N	\N
43f7f3e2-7124-4fae-b564-bd9b6430772c	\N	auth-otp-form	68d4a947-cff1-493f-8942-868a60f3a7a4	fff228ad-c8d1-41bd-91f1-4d5ea86ac0f5	0	20	f	\N	\N
1dabfad6-18ca-4dd5-b68e-3116ebbc0fb0	\N	http-basic-authenticator	68d4a947-cff1-493f-8942-868a60f3a7a4	341b88ce-aa9f-439f-8eb2-f85792b7c0e8	0	10	f	\N	\N
b1436aaa-eced-42fc-98ed-b62ba23218c6	\N	docker-http-basic-authenticator	68d4a947-cff1-493f-8942-868a60f3a7a4	0cb50458-fb21-4fce-8796-1ca39d56f086	0	10	f	\N	\N
1185e718-375c-496a-ad16-8066d5515934	\N	auth-cookie	03f0b788-c519-457c-9b1d-cc8412c32a1a	7b543bc7-792f-4c75-87f1-06422cca581b	2	10	f	\N	\N
3950789a-a2de-40db-9077-45de9ec582e3	\N	auth-spnego	03f0b788-c519-457c-9b1d-cc8412c32a1a	7b543bc7-792f-4c75-87f1-06422cca581b	3	20	f	\N	\N
5de72f33-7528-4ab5-88d2-15dd6304f211	\N	identity-provider-redirector	03f0b788-c519-457c-9b1d-cc8412c32a1a	7b543bc7-792f-4c75-87f1-06422cca581b	2	25	f	\N	\N
1a875f56-42f9-4b32-bdcf-f2644cd00147	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	7b543bc7-792f-4c75-87f1-06422cca581b	2	30	t	48f728ae-e807-446b-9631-e444f4e08d1d	\N
3e6c4ec8-6807-4262-aaf3-3ab66c0399aa	\N	auth-username-password-form	03f0b788-c519-457c-9b1d-cc8412c32a1a	48f728ae-e807-446b-9631-e444f4e08d1d	0	10	f	\N	\N
d2db6edc-cd14-4f0e-bd03-a354858c24b3	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	48f728ae-e807-446b-9631-e444f4e08d1d	1	20	t	117c6db5-76dd-4873-87b8-ea88916a9ab8	\N
7868d789-2c16-4ba9-8164-c0c66c9e854e	\N	conditional-user-configured	03f0b788-c519-457c-9b1d-cc8412c32a1a	117c6db5-76dd-4873-87b8-ea88916a9ab8	0	10	f	\N	\N
34f77bbf-14a9-44ac-a703-82b5eb5873af	\N	auth-otp-form	03f0b788-c519-457c-9b1d-cc8412c32a1a	117c6db5-76dd-4873-87b8-ea88916a9ab8	0	20	f	\N	\N
5f9b4f58-4b8a-41bc-89fc-ba07ee1cecae	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	7b543bc7-792f-4c75-87f1-06422cca581b	2	26	t	7524d636-996e-4c9d-9acd-dd282d5c3d92	\N
b1e75e83-2349-4abf-b672-9486925c834a	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	7524d636-996e-4c9d-9acd-dd282d5c3d92	1	10	t	2cbd0df2-a9f4-4b5e-92e4-720af08e184a	\N
56d0e8d0-b872-4654-ba5b-ac765c82c35a	\N	conditional-user-configured	03f0b788-c519-457c-9b1d-cc8412c32a1a	2cbd0df2-a9f4-4b5e-92e4-720af08e184a	0	10	f	\N	\N
ed50952e-a4af-4dec-963e-5bd948a7dbe5	\N	organization	03f0b788-c519-457c-9b1d-cc8412c32a1a	2cbd0df2-a9f4-4b5e-92e4-720af08e184a	2	20	f	\N	\N
a8d67458-18ce-4837-9e44-d52e7925d624	\N	direct-grant-validate-username	03f0b788-c519-457c-9b1d-cc8412c32a1a	e308a996-9532-4425-8356-77c767bbc0c7	0	10	f	\N	\N
34fc964a-50d9-46f2-a87d-5446d59fc56a	\N	direct-grant-validate-password	03f0b788-c519-457c-9b1d-cc8412c32a1a	e308a996-9532-4425-8356-77c767bbc0c7	0	20	f	\N	\N
d550bfa8-a7dc-4a4a-9ff5-1a972fece8da	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	e308a996-9532-4425-8356-77c767bbc0c7	1	30	t	1a6f366e-e6f6-46b4-9f69-5ec1abf2b096	\N
f7d871ea-37cf-4ec8-89ad-8405ce9a1685	\N	conditional-user-configured	03f0b788-c519-457c-9b1d-cc8412c32a1a	1a6f366e-e6f6-46b4-9f69-5ec1abf2b096	0	10	f	\N	\N
05f1261a-b318-44c4-b3eb-3d103578162b	\N	direct-grant-validate-otp	03f0b788-c519-457c-9b1d-cc8412c32a1a	1a6f366e-e6f6-46b4-9f69-5ec1abf2b096	0	20	f	\N	\N
09c508d2-4406-432f-a036-0e98261e591d	\N	registration-page-form	03f0b788-c519-457c-9b1d-cc8412c32a1a	4f85b939-df9f-4bb2-8075-fcbbbe50a1d5	0	10	t	67e0811a-2d66-46c1-879d-bacbb5086da2	\N
47041e1a-eea7-42ff-8ca0-627c433da1e0	\N	registration-user-creation	03f0b788-c519-457c-9b1d-cc8412c32a1a	67e0811a-2d66-46c1-879d-bacbb5086da2	0	20	f	\N	\N
1a43e67f-d5e0-4180-b814-4b345f5accd8	\N	registration-password-action	03f0b788-c519-457c-9b1d-cc8412c32a1a	67e0811a-2d66-46c1-879d-bacbb5086da2	0	50	f	\N	\N
b8c363fb-854f-40f0-b61d-80c9672d90e3	\N	registration-recaptcha-action	03f0b788-c519-457c-9b1d-cc8412c32a1a	67e0811a-2d66-46c1-879d-bacbb5086da2	3	60	f	\N	\N
88249537-890a-4f22-94cf-6fdeeced1cc8	\N	registration-terms-and-conditions	03f0b788-c519-457c-9b1d-cc8412c32a1a	67e0811a-2d66-46c1-879d-bacbb5086da2	3	70	f	\N	\N
5ebc75ac-c3b3-4c17-a514-ba2cf3f8f20d	\N	reset-credentials-choose-user	03f0b788-c519-457c-9b1d-cc8412c32a1a	ebdbcf89-7984-4f51-9279-a018f5e6fd81	0	10	f	\N	\N
30581074-58da-420b-b679-2976d6de6d6a	\N	reset-credential-email	03f0b788-c519-457c-9b1d-cc8412c32a1a	ebdbcf89-7984-4f51-9279-a018f5e6fd81	0	20	f	\N	\N
80bc6e29-39bd-4b3c-a8ae-0e5c36ac7d10	\N	reset-password	03f0b788-c519-457c-9b1d-cc8412c32a1a	ebdbcf89-7984-4f51-9279-a018f5e6fd81	0	30	f	\N	\N
2e3a0f72-8b0a-444b-b3d5-76706a323a29	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	ebdbcf89-7984-4f51-9279-a018f5e6fd81	1	40	t	1ed555f8-1f78-4cd8-b530-31908f01ccc0	\N
8e2e2de8-7d7d-471e-a005-b178f67c2195	\N	conditional-user-configured	03f0b788-c519-457c-9b1d-cc8412c32a1a	1ed555f8-1f78-4cd8-b530-31908f01ccc0	0	10	f	\N	\N
66b235e0-a136-43ec-855f-ffba9858b94e	\N	reset-otp	03f0b788-c519-457c-9b1d-cc8412c32a1a	1ed555f8-1f78-4cd8-b530-31908f01ccc0	0	20	f	\N	\N
240e641c-e4b1-40d9-aac9-a4fe1c164c58	\N	client-secret	03f0b788-c519-457c-9b1d-cc8412c32a1a	8041a3a2-d14f-4181-ad6f-a19683a85a75	2	10	f	\N	\N
3320afc2-7547-4cd0-90c9-baff4c3bb42d	\N	client-jwt	03f0b788-c519-457c-9b1d-cc8412c32a1a	8041a3a2-d14f-4181-ad6f-a19683a85a75	2	20	f	\N	\N
fe909cde-89b7-496e-8cdb-7ee87a0787a3	\N	client-secret-jwt	03f0b788-c519-457c-9b1d-cc8412c32a1a	8041a3a2-d14f-4181-ad6f-a19683a85a75	2	30	f	\N	\N
bf7cdb64-e3d7-4215-84aa-965a18cc0ffa	\N	client-x509	03f0b788-c519-457c-9b1d-cc8412c32a1a	8041a3a2-d14f-4181-ad6f-a19683a85a75	2	40	f	\N	\N
8a497455-9652-49f4-8216-8111221495e4	\N	idp-review-profile	03f0b788-c519-457c-9b1d-cc8412c32a1a	f253863e-b9d7-4998-b687-d40e326145b5	0	10	f	\N	862a2c5f-0a9a-4fa1-b104-559577195745
81cc40b2-96ac-475c-a734-58a33a8d8127	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	f253863e-b9d7-4998-b687-d40e326145b5	0	20	t	19107a0e-7af2-420f-82aa-956b321b63e2	\N
41a2d1e0-c946-4b96-9c17-b7614c33e5c6	\N	idp-create-user-if-unique	03f0b788-c519-457c-9b1d-cc8412c32a1a	19107a0e-7af2-420f-82aa-956b321b63e2	2	10	f	\N	3075e4b1-b038-40b5-83f3-b19fc0a234a0
a2485c5b-a811-4f29-9026-6c10fbe05ef7	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	19107a0e-7af2-420f-82aa-956b321b63e2	2	20	t	7f33fbc2-4bdb-4b36-ac3a-1f878452e940	\N
0f9a5704-5c5c-4e86-b97e-799aec724a31	\N	idp-confirm-link	03f0b788-c519-457c-9b1d-cc8412c32a1a	7f33fbc2-4bdb-4b36-ac3a-1f878452e940	0	10	f	\N	\N
2884ed9e-39a7-48c2-8d75-129bb50185c0	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	7f33fbc2-4bdb-4b36-ac3a-1f878452e940	0	20	t	a9a76100-8f8e-4ef0-b0b1-b2272a02bfad	\N
c9294af7-c371-4b46-973b-e22844e1fd22	\N	idp-email-verification	03f0b788-c519-457c-9b1d-cc8412c32a1a	a9a76100-8f8e-4ef0-b0b1-b2272a02bfad	2	10	f	\N	\N
97a444da-c146-4b94-ba62-7d9e1897d18a	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	a9a76100-8f8e-4ef0-b0b1-b2272a02bfad	2	20	t	6ae817ce-587b-4df0-8afa-07398267a960	\N
8ca2b6fe-f4ff-42f1-a5aa-46691838d0ac	\N	idp-username-password-form	03f0b788-c519-457c-9b1d-cc8412c32a1a	6ae817ce-587b-4df0-8afa-07398267a960	0	10	f	\N	\N
7d11693c-64a6-4235-9a6b-8416fb48988c	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	6ae817ce-587b-4df0-8afa-07398267a960	1	20	t	349a29cd-9575-4643-b576-135a7143d29e	\N
ac8f1c82-a7a0-42f1-885a-19e90193491b	\N	conditional-user-configured	03f0b788-c519-457c-9b1d-cc8412c32a1a	349a29cd-9575-4643-b576-135a7143d29e	0	10	f	\N	\N
29dc4b62-50b5-4d63-895a-798c98a1c19c	\N	auth-otp-form	03f0b788-c519-457c-9b1d-cc8412c32a1a	349a29cd-9575-4643-b576-135a7143d29e	0	20	f	\N	\N
db3e0595-d7e8-48e5-a281-cc9468f730bf	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	f253863e-b9d7-4998-b687-d40e326145b5	1	50	t	519284d1-e33f-48e5-9516-33a46e1b04fc	\N
484b2197-6433-4077-86c4-3a7c36de21d0	\N	conditional-user-configured	03f0b788-c519-457c-9b1d-cc8412c32a1a	519284d1-e33f-48e5-9516-33a46e1b04fc	0	10	f	\N	\N
db68ec60-fc4d-4ce1-8b98-76d20441e768	\N	idp-add-organization-member	03f0b788-c519-457c-9b1d-cc8412c32a1a	519284d1-e33f-48e5-9516-33a46e1b04fc	0	20	f	\N	\N
23c4ff3f-8f6b-405a-854f-b03f82532b4e	\N	http-basic-authenticator	03f0b788-c519-457c-9b1d-cc8412c32a1a	8307d225-6e8f-4c36-b49f-0e25bf569a8e	0	10	f	\N	\N
a00c07ab-1944-41e5-9b7e-519b75b36a0c	\N	docker-http-basic-authenticator	03f0b788-c519-457c-9b1d-cc8412c32a1a	b808dc26-b571-42de-ac7b-72b0c630427e	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
06266cab-15a5-4807-ad2d-801fe6ee875e	browser	Browser based authentication	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
d396c7fa-5ad7-4e7a-b053-fc964df2bfa3	forms	Username, password, otp and other auth forms.	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
a367b6cc-1691-4034-bb92-bcf7041ec2ac	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
4d776a13-6822-4604-98cd-e848385b8add	direct grant	OpenID Connect Resource Owner Grant	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
7056d64b-1147-47a0-a034-623d9ac21d23	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
cb79672d-8778-4fe4-8da8-34fad42332c3	registration	Registration flow	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
acad2059-5fa3-41f4-b500-a6cf1bed8764	registration form	Registration form	68d4a947-cff1-493f-8942-868a60f3a7a4	form-flow	f	t
37d54ee1-5f22-4064-8ca7-90c5699ce205	reset credentials	Reset credentials for a user if they forgot their password or something	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
bda8e01d-3dc8-4b2d-aa1f-ab5ebe51076a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
ed28a595-5a40-436c-933d-91f8f2b8a64f	clients	Base authentication for clients	68d4a947-cff1-493f-8942-868a60f3a7a4	client-flow	t	t
8baaeddb-fad8-49d3-99dc-57a2cb9849c9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
967e18f4-430a-420e-98d5-1deeb1f29105	User creation or linking	Flow for the existing/non-existing user alternatives	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
fc1a8c9a-ab4d-4d6b-9fb2-1c34ceccefdb	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
570493ce-8039-4485-bb2b-b5b99f5eb685	Account verification options	Method with which to verity the existing account	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
681cbc4e-b5b3-4a25-b291-a09b59d1069e	Verify Existing Account by Re-authentication	Reauthentication of existing account	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
fff228ad-c8d1-41bd-91f1-4d5ea86ac0f5	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	f	t
341b88ce-aa9f-439f-8eb2-f85792b7c0e8	saml ecp	SAML ECP Profile Authentication Flow	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
0cb50458-fb21-4fce-8796-1ca39d56f086	docker auth	Used by Docker clients to authenticate against the IDP	68d4a947-cff1-493f-8942-868a60f3a7a4	basic-flow	t	t
7b543bc7-792f-4c75-87f1-06422cca581b	browser	Browser based authentication	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
48f728ae-e807-446b-9631-e444f4e08d1d	forms	Username, password, otp and other auth forms.	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
117c6db5-76dd-4873-87b8-ea88916a9ab8	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
7524d636-996e-4c9d-9acd-dd282d5c3d92	Organization	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
2cbd0df2-a9f4-4b5e-92e4-720af08e184a	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
e308a996-9532-4425-8356-77c767bbc0c7	direct grant	OpenID Connect Resource Owner Grant	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
1a6f366e-e6f6-46b4-9f69-5ec1abf2b096	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
4f85b939-df9f-4bb2-8075-fcbbbe50a1d5	registration	Registration flow	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
67e0811a-2d66-46c1-879d-bacbb5086da2	registration form	Registration form	03f0b788-c519-457c-9b1d-cc8412c32a1a	form-flow	f	t
ebdbcf89-7984-4f51-9279-a018f5e6fd81	reset credentials	Reset credentials for a user if they forgot their password or something	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
1ed555f8-1f78-4cd8-b530-31908f01ccc0	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
8041a3a2-d14f-4181-ad6f-a19683a85a75	clients	Base authentication for clients	03f0b788-c519-457c-9b1d-cc8412c32a1a	client-flow	t	t
f253863e-b9d7-4998-b687-d40e326145b5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
19107a0e-7af2-420f-82aa-956b321b63e2	User creation or linking	Flow for the existing/non-existing user alternatives	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
7f33fbc2-4bdb-4b36-ac3a-1f878452e940	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
a9a76100-8f8e-4ef0-b0b1-b2272a02bfad	Account verification options	Method with which to verity the existing account	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
6ae817ce-587b-4df0-8afa-07398267a960	Verify Existing Account by Re-authentication	Reauthentication of existing account	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
349a29cd-9575-4643-b576-135a7143d29e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
519284d1-e33f-48e5-9516-33a46e1b04fc	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	f	t
8307d225-6e8f-4c36-b49f-0e25bf569a8e	saml ecp	SAML ECP Profile Authentication Flow	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
b808dc26-b571-42de-ac7b-72b0c630427e	docker auth	Used by Docker clients to authenticate against the IDP	03f0b788-c519-457c-9b1d-cc8412c32a1a	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
25a7b377-406d-4af2-bf62-bb687506c2f3	review profile config	68d4a947-cff1-493f-8942-868a60f3a7a4
4a78e2b2-1bc8-4860-a33d-5954137df5a0	create unique user config	68d4a947-cff1-493f-8942-868a60f3a7a4
862a2c5f-0a9a-4fa1-b104-559577195745	review profile config	03f0b788-c519-457c-9b1d-cc8412c32a1a
3075e4b1-b038-40b5-83f3-b19fc0a234a0	create unique user config	03f0b788-c519-457c-9b1d-cc8412c32a1a
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
25a7b377-406d-4af2-bf62-bb687506c2f3	missing	update.profile.on.first.login
4a78e2b2-1bc8-4860-a33d-5954137df5a0	false	require.password.update.after.registration
3075e4b1-b038-40b5-83f3-b19fc0a234a0	false	require.password.update.after.registration
862a2c5f-0a9a-4fa1-b104-559577195745	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
8fb0377b-b032-4b45-837b-190c9c97c494	t	f	master-realm	0	f	\N	\N	t	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
0f42204d-a34b-47a3-909a-f719aab1800f	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	t	f	broker	0	f	\N	\N	t	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
5bbfe09f-079f-40e6-aa17-33fc2e201325	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e4193b43-44d4-409f-895f-e2cff07f4cd5	t	t	admin-cli	0	t	\N	\N	f	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	f	applier-realm	0	f	\N	\N	t	\N	f	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	0	f	f	applier Realm	f	client-secret	\N	\N	\N	t	f	f	f
443f53e9-45e1-4bd3-a462-bd257a953687	t	f	realm-management	0	f	\N	\N	t	\N	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
2173459a-3937-4744-a323-e9f6ec19f1bc	t	f	account	0	t	\N	/realms/applier/account/	f	\N	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	t	f	account-console	0	t	\N	/realms/applier/account/	f	\N	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
25be3665-8f22-473e-84a8-98b6159c8667	t	f	broker	0	f	\N	\N	t	\N	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
972a6183-c205-4fcf-8ac3-649e22dd4a40	t	t	security-admin-console	0	t	\N	/admin/applier/console/	f	\N	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
abfedbc2-57f9-4133-8eec-b4c9af26874d	t	t	admin-cli	0	t	\N	\N	f	\N	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
5098521b-57a9-4016-ba7f-4d03d33341aa	t	t	applier	0	t	\N	http://localhost:8081	f	http://localhost:8081	f	03f0b788-c519-457c-9b1d-cc8412c32a1a	openid-connect	-1	t	f		f	client-secret	http://localhost:8081		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
0f42204d-a34b-47a3-909a-f719aab1800f	post.logout.redirect.uris	+
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	post.logout.redirect.uris	+
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	pkce.code.challenge.method	S256
5bbfe09f-079f-40e6-aa17-33fc2e201325	post.logout.redirect.uris	+
5bbfe09f-079f-40e6-aa17-33fc2e201325	pkce.code.challenge.method	S256
5bbfe09f-079f-40e6-aa17-33fc2e201325	client.use.lightweight.access.token.enabled	true
e4193b43-44d4-409f-895f-e2cff07f4cd5	client.use.lightweight.access.token.enabled	true
2173459a-3937-4744-a323-e9f6ec19f1bc	post.logout.redirect.uris	+
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	post.logout.redirect.uris	+
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	pkce.code.challenge.method	S256
972a6183-c205-4fcf-8ac3-649e22dd4a40	post.logout.redirect.uris	+
972a6183-c205-4fcf-8ac3-649e22dd4a40	pkce.code.challenge.method	S256
972a6183-c205-4fcf-8ac3-649e22dd4a40	client.use.lightweight.access.token.enabled	true
abfedbc2-57f9-4133-8eec-b4c9af26874d	client.use.lightweight.access.token.enabled	true
5098521b-57a9-4016-ba7f-4d03d33341aa	oauth2.device.authorization.grant.enabled	false
5098521b-57a9-4016-ba7f-4d03d33341aa	oidc.ciba.grant.enabled	false
5098521b-57a9-4016-ba7f-4d03d33341aa	post.logout.redirect.uris	*
5098521b-57a9-4016-ba7f-4d03d33341aa	backchannel.logout.session.required	true
5098521b-57a9-4016-ba7f-4d03d33341aa	backchannel.logout.revoke.offline.tokens	false
5098521b-57a9-4016-ba7f-4d03d33341aa	realm_client	false
5098521b-57a9-4016-ba7f-4d03d33341aa	display.on.consent.screen	false
5098521b-57a9-4016-ba7f-4d03d33341aa	client.secret.creation.time	1792007863
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
5a6c03cd-c40c-4452-8d15-0461d47fd31d	offline_access	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect built-in scope: offline_access	openid-connect
751dbbcb-c23b-410b-b775-794579d803ac	role_list	68d4a947-cff1-493f-8942-868a60f3a7a4	SAML role list	saml
50a32981-6b0e-4554-81a0-f3e42d21f57e	saml_organization	68d4a947-cff1-493f-8942-868a60f3a7a4	Organization Membership	saml
7c62a1af-f66d-466f-9026-e91675699943	profile	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect built-in scope: profile	openid-connect
6b300b86-f1b2-4adb-b409-7ab72fccd793	email	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect built-in scope: email	openid-connect
efe74689-67ce-4d03-9f2d-575310ba3b4c	address	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect built-in scope: address	openid-connect
9f4720c6-15fe-46c1-88c7-0a81b7602f25	phone	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect built-in scope: phone	openid-connect
83f083d9-ace0-4e0f-8274-d1009d869f7a	roles	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect scope for add user roles to the access token	openid-connect
2e359507-360b-4260-9309-95c709fd5cb8	web-origins	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect scope for add allowed web origins to the access token	openid-connect
22ce36dc-337b-4ac1-835d-1142550f2204	microprofile-jwt	68d4a947-cff1-493f-8942-868a60f3a7a4	Microprofile - JWT built-in scope	openid-connect
c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	acr	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
5674f905-4e9c-4b68-ae9d-47786d56ab0a	basic	68d4a947-cff1-493f-8942-868a60f3a7a4	OpenID Connect scope for add all basic claims to the token	openid-connect
9d00ab33-c436-4328-94fb-ec92697c3859	organization	68d4a947-cff1-493f-8942-868a60f3a7a4	Additional claims about the organization a subject belongs to	openid-connect
920ec61c-7718-4516-a4ef-408c702eae0d	offline_access	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect built-in scope: offline_access	openid-connect
08c28948-e0f7-4b3c-98eb-5dd29cd4d4ec	role_list	03f0b788-c519-457c-9b1d-cc8412c32a1a	SAML role list	saml
8949d8f9-0655-4b31-8191-126408ff07b3	saml_organization	03f0b788-c519-457c-9b1d-cc8412c32a1a	Organization Membership	saml
6390e957-2228-4f3e-96a7-7cdfe1736b55	profile	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect built-in scope: profile	openid-connect
16ad216f-2f33-4851-b1cc-293a7b7c8ad6	email	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect built-in scope: email	openid-connect
371436c2-48f3-4c45-b871-e976cd7d5040	address	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect built-in scope: address	openid-connect
cd55ae5e-4223-4f84-84d6-09ee06553663	phone	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect built-in scope: phone	openid-connect
4d834829-0d7d-465d-b5df-f981b193abd1	roles	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect scope for add user roles to the access token	openid-connect
8715b8e4-7312-486f-87eb-0c798bdc64be	web-origins	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
11441a96-9d9a-49fe-b6b0-de0af5ce54d9	microprofile-jwt	03f0b788-c519-457c-9b1d-cc8412c32a1a	Microprofile - JWT built-in scope	openid-connect
0d392f78-68e2-4b6c-9661-04aedde04310	acr	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
db8181c1-1294-49bb-8188-90dc59ee4d73	basic	03f0b788-c519-457c-9b1d-cc8412c32a1a	OpenID Connect scope for add all basic claims to the token	openid-connect
90125165-0499-4bec-88d9-e7158d7a3990	organization	03f0b788-c519-457c-9b1d-cc8412c32a1a	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
5a6c03cd-c40c-4452-8d15-0461d47fd31d	true	display.on.consent.screen
5a6c03cd-c40c-4452-8d15-0461d47fd31d	${offlineAccessScopeConsentText}	consent.screen.text
751dbbcb-c23b-410b-b775-794579d803ac	true	display.on.consent.screen
751dbbcb-c23b-410b-b775-794579d803ac	${samlRoleListScopeConsentText}	consent.screen.text
50a32981-6b0e-4554-81a0-f3e42d21f57e	false	display.on.consent.screen
7c62a1af-f66d-466f-9026-e91675699943	true	display.on.consent.screen
7c62a1af-f66d-466f-9026-e91675699943	${profileScopeConsentText}	consent.screen.text
7c62a1af-f66d-466f-9026-e91675699943	true	include.in.token.scope
6b300b86-f1b2-4adb-b409-7ab72fccd793	true	display.on.consent.screen
6b300b86-f1b2-4adb-b409-7ab72fccd793	${emailScopeConsentText}	consent.screen.text
6b300b86-f1b2-4adb-b409-7ab72fccd793	true	include.in.token.scope
efe74689-67ce-4d03-9f2d-575310ba3b4c	true	display.on.consent.screen
efe74689-67ce-4d03-9f2d-575310ba3b4c	${addressScopeConsentText}	consent.screen.text
efe74689-67ce-4d03-9f2d-575310ba3b4c	true	include.in.token.scope
9f4720c6-15fe-46c1-88c7-0a81b7602f25	true	display.on.consent.screen
9f4720c6-15fe-46c1-88c7-0a81b7602f25	${phoneScopeConsentText}	consent.screen.text
9f4720c6-15fe-46c1-88c7-0a81b7602f25	true	include.in.token.scope
83f083d9-ace0-4e0f-8274-d1009d869f7a	true	display.on.consent.screen
83f083d9-ace0-4e0f-8274-d1009d869f7a	${rolesScopeConsentText}	consent.screen.text
83f083d9-ace0-4e0f-8274-d1009d869f7a	false	include.in.token.scope
2e359507-360b-4260-9309-95c709fd5cb8	false	display.on.consent.screen
2e359507-360b-4260-9309-95c709fd5cb8		consent.screen.text
2e359507-360b-4260-9309-95c709fd5cb8	false	include.in.token.scope
22ce36dc-337b-4ac1-835d-1142550f2204	false	display.on.consent.screen
22ce36dc-337b-4ac1-835d-1142550f2204	true	include.in.token.scope
c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	false	display.on.consent.screen
c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	false	include.in.token.scope
5674f905-4e9c-4b68-ae9d-47786d56ab0a	false	display.on.consent.screen
5674f905-4e9c-4b68-ae9d-47786d56ab0a	false	include.in.token.scope
9d00ab33-c436-4328-94fb-ec92697c3859	true	display.on.consent.screen
9d00ab33-c436-4328-94fb-ec92697c3859	${organizationScopeConsentText}	consent.screen.text
9d00ab33-c436-4328-94fb-ec92697c3859	true	include.in.token.scope
920ec61c-7718-4516-a4ef-408c702eae0d	true	display.on.consent.screen
920ec61c-7718-4516-a4ef-408c702eae0d	${offlineAccessScopeConsentText}	consent.screen.text
08c28948-e0f7-4b3c-98eb-5dd29cd4d4ec	true	display.on.consent.screen
08c28948-e0f7-4b3c-98eb-5dd29cd4d4ec	${samlRoleListScopeConsentText}	consent.screen.text
8949d8f9-0655-4b31-8191-126408ff07b3	false	display.on.consent.screen
6390e957-2228-4f3e-96a7-7cdfe1736b55	true	display.on.consent.screen
6390e957-2228-4f3e-96a7-7cdfe1736b55	${profileScopeConsentText}	consent.screen.text
6390e957-2228-4f3e-96a7-7cdfe1736b55	true	include.in.token.scope
16ad216f-2f33-4851-b1cc-293a7b7c8ad6	true	display.on.consent.screen
16ad216f-2f33-4851-b1cc-293a7b7c8ad6	${emailScopeConsentText}	consent.screen.text
16ad216f-2f33-4851-b1cc-293a7b7c8ad6	true	include.in.token.scope
371436c2-48f3-4c45-b871-e976cd7d5040	true	display.on.consent.screen
371436c2-48f3-4c45-b871-e976cd7d5040	${addressScopeConsentText}	consent.screen.text
371436c2-48f3-4c45-b871-e976cd7d5040	true	include.in.token.scope
cd55ae5e-4223-4f84-84d6-09ee06553663	true	display.on.consent.screen
cd55ae5e-4223-4f84-84d6-09ee06553663	${phoneScopeConsentText}	consent.screen.text
cd55ae5e-4223-4f84-84d6-09ee06553663	true	include.in.token.scope
4d834829-0d7d-465d-b5df-f981b193abd1	true	display.on.consent.screen
4d834829-0d7d-465d-b5df-f981b193abd1	${rolesScopeConsentText}	consent.screen.text
4d834829-0d7d-465d-b5df-f981b193abd1	false	include.in.token.scope
8715b8e4-7312-486f-87eb-0c798bdc64be	false	display.on.consent.screen
8715b8e4-7312-486f-87eb-0c798bdc64be		consent.screen.text
8715b8e4-7312-486f-87eb-0c798bdc64be	false	include.in.token.scope
11441a96-9d9a-49fe-b6b0-de0af5ce54d9	false	display.on.consent.screen
11441a96-9d9a-49fe-b6b0-de0af5ce54d9	true	include.in.token.scope
0d392f78-68e2-4b6c-9661-04aedde04310	false	display.on.consent.screen
0d392f78-68e2-4b6c-9661-04aedde04310	false	include.in.token.scope
db8181c1-1294-49bb-8188-90dc59ee4d73	false	display.on.consent.screen
db8181c1-1294-49bb-8188-90dc59ee4d73	false	include.in.token.scope
90125165-0499-4bec-88d9-e7158d7a3990	true	display.on.consent.screen
90125165-0499-4bec-88d9-e7158d7a3990	${organizationScopeConsentText}	consent.screen.text
90125165-0499-4bec-88d9-e7158d7a3990	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
0f42204d-a34b-47a3-909a-f719aab1800f	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
0f42204d-a34b-47a3-909a-f719aab1800f	7c62a1af-f66d-466f-9026-e91675699943	t
0f42204d-a34b-47a3-909a-f719aab1800f	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
0f42204d-a34b-47a3-909a-f719aab1800f	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
0f42204d-a34b-47a3-909a-f719aab1800f	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
0f42204d-a34b-47a3-909a-f719aab1800f	2e359507-360b-4260-9309-95c709fd5cb8	t
0f42204d-a34b-47a3-909a-f719aab1800f	22ce36dc-337b-4ac1-835d-1142550f2204	f
0f42204d-a34b-47a3-909a-f719aab1800f	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
0f42204d-a34b-47a3-909a-f719aab1800f	9d00ab33-c436-4328-94fb-ec92697c3859	f
0f42204d-a34b-47a3-909a-f719aab1800f	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
0f42204d-a34b-47a3-909a-f719aab1800f	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	7c62a1af-f66d-466f-9026-e91675699943	t
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	2e359507-360b-4260-9309-95c709fd5cb8	t
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	22ce36dc-337b-4ac1-835d-1142550f2204	f
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	9d00ab33-c436-4328-94fb-ec92697c3859	f
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
e4193b43-44d4-409f-895f-e2cff07f4cd5	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
e4193b43-44d4-409f-895f-e2cff07f4cd5	7c62a1af-f66d-466f-9026-e91675699943	t
e4193b43-44d4-409f-895f-e2cff07f4cd5	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
e4193b43-44d4-409f-895f-e2cff07f4cd5	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
e4193b43-44d4-409f-895f-e2cff07f4cd5	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
e4193b43-44d4-409f-895f-e2cff07f4cd5	2e359507-360b-4260-9309-95c709fd5cb8	t
e4193b43-44d4-409f-895f-e2cff07f4cd5	22ce36dc-337b-4ac1-835d-1142550f2204	f
e4193b43-44d4-409f-895f-e2cff07f4cd5	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
e4193b43-44d4-409f-895f-e2cff07f4cd5	9d00ab33-c436-4328-94fb-ec92697c3859	f
e4193b43-44d4-409f-895f-e2cff07f4cd5	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
e4193b43-44d4-409f-895f-e2cff07f4cd5	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	7c62a1af-f66d-466f-9026-e91675699943	t
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	2e359507-360b-4260-9309-95c709fd5cb8	t
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	22ce36dc-337b-4ac1-835d-1142550f2204	f
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	9d00ab33-c436-4328-94fb-ec92697c3859	f
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
8fb0377b-b032-4b45-837b-190c9c97c494	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
8fb0377b-b032-4b45-837b-190c9c97c494	7c62a1af-f66d-466f-9026-e91675699943	t
8fb0377b-b032-4b45-837b-190c9c97c494	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
8fb0377b-b032-4b45-837b-190c9c97c494	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
8fb0377b-b032-4b45-837b-190c9c97c494	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
8fb0377b-b032-4b45-837b-190c9c97c494	2e359507-360b-4260-9309-95c709fd5cb8	t
8fb0377b-b032-4b45-837b-190c9c97c494	22ce36dc-337b-4ac1-835d-1142550f2204	f
8fb0377b-b032-4b45-837b-190c9c97c494	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
8fb0377b-b032-4b45-837b-190c9c97c494	9d00ab33-c436-4328-94fb-ec92697c3859	f
8fb0377b-b032-4b45-837b-190c9c97c494	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
8fb0377b-b032-4b45-837b-190c9c97c494	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
5bbfe09f-079f-40e6-aa17-33fc2e201325	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
5bbfe09f-079f-40e6-aa17-33fc2e201325	7c62a1af-f66d-466f-9026-e91675699943	t
5bbfe09f-079f-40e6-aa17-33fc2e201325	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
5bbfe09f-079f-40e6-aa17-33fc2e201325	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
5bbfe09f-079f-40e6-aa17-33fc2e201325	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
5bbfe09f-079f-40e6-aa17-33fc2e201325	2e359507-360b-4260-9309-95c709fd5cb8	t
5bbfe09f-079f-40e6-aa17-33fc2e201325	22ce36dc-337b-4ac1-835d-1142550f2204	f
5bbfe09f-079f-40e6-aa17-33fc2e201325	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
5bbfe09f-079f-40e6-aa17-33fc2e201325	9d00ab33-c436-4328-94fb-ec92697c3859	f
5bbfe09f-079f-40e6-aa17-33fc2e201325	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
5bbfe09f-079f-40e6-aa17-33fc2e201325	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
2173459a-3937-4744-a323-e9f6ec19f1bc	4d834829-0d7d-465d-b5df-f981b193abd1	t
2173459a-3937-4744-a323-e9f6ec19f1bc	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
2173459a-3937-4744-a323-e9f6ec19f1bc	0d392f78-68e2-4b6c-9661-04aedde04310	t
2173459a-3937-4744-a323-e9f6ec19f1bc	8715b8e4-7312-486f-87eb-0c798bdc64be	t
2173459a-3937-4744-a323-e9f6ec19f1bc	db8181c1-1294-49bb-8188-90dc59ee4d73	t
2173459a-3937-4744-a323-e9f6ec19f1bc	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
2173459a-3937-4744-a323-e9f6ec19f1bc	920ec61c-7718-4516-a4ef-408c702eae0d	f
2173459a-3937-4744-a323-e9f6ec19f1bc	cd55ae5e-4223-4f84-84d6-09ee06553663	f
2173459a-3937-4744-a323-e9f6ec19f1bc	371436c2-48f3-4c45-b871-e976cd7d5040	f
2173459a-3937-4744-a323-e9f6ec19f1bc	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
2173459a-3937-4744-a323-e9f6ec19f1bc	90125165-0499-4bec-88d9-e7158d7a3990	f
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	4d834829-0d7d-465d-b5df-f981b193abd1	t
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	0d392f78-68e2-4b6c-9661-04aedde04310	t
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	8715b8e4-7312-486f-87eb-0c798bdc64be	t
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	db8181c1-1294-49bb-8188-90dc59ee4d73	t
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	920ec61c-7718-4516-a4ef-408c702eae0d	f
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	cd55ae5e-4223-4f84-84d6-09ee06553663	f
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	371436c2-48f3-4c45-b871-e976cd7d5040	f
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	90125165-0499-4bec-88d9-e7158d7a3990	f
abfedbc2-57f9-4133-8eec-b4c9af26874d	4d834829-0d7d-465d-b5df-f981b193abd1	t
abfedbc2-57f9-4133-8eec-b4c9af26874d	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
abfedbc2-57f9-4133-8eec-b4c9af26874d	0d392f78-68e2-4b6c-9661-04aedde04310	t
abfedbc2-57f9-4133-8eec-b4c9af26874d	8715b8e4-7312-486f-87eb-0c798bdc64be	t
abfedbc2-57f9-4133-8eec-b4c9af26874d	db8181c1-1294-49bb-8188-90dc59ee4d73	t
abfedbc2-57f9-4133-8eec-b4c9af26874d	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
abfedbc2-57f9-4133-8eec-b4c9af26874d	920ec61c-7718-4516-a4ef-408c702eae0d	f
abfedbc2-57f9-4133-8eec-b4c9af26874d	cd55ae5e-4223-4f84-84d6-09ee06553663	f
abfedbc2-57f9-4133-8eec-b4c9af26874d	371436c2-48f3-4c45-b871-e976cd7d5040	f
abfedbc2-57f9-4133-8eec-b4c9af26874d	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
abfedbc2-57f9-4133-8eec-b4c9af26874d	90125165-0499-4bec-88d9-e7158d7a3990	f
25be3665-8f22-473e-84a8-98b6159c8667	4d834829-0d7d-465d-b5df-f981b193abd1	t
25be3665-8f22-473e-84a8-98b6159c8667	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
25be3665-8f22-473e-84a8-98b6159c8667	0d392f78-68e2-4b6c-9661-04aedde04310	t
25be3665-8f22-473e-84a8-98b6159c8667	8715b8e4-7312-486f-87eb-0c798bdc64be	t
25be3665-8f22-473e-84a8-98b6159c8667	db8181c1-1294-49bb-8188-90dc59ee4d73	t
25be3665-8f22-473e-84a8-98b6159c8667	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
25be3665-8f22-473e-84a8-98b6159c8667	920ec61c-7718-4516-a4ef-408c702eae0d	f
25be3665-8f22-473e-84a8-98b6159c8667	cd55ae5e-4223-4f84-84d6-09ee06553663	f
25be3665-8f22-473e-84a8-98b6159c8667	371436c2-48f3-4c45-b871-e976cd7d5040	f
25be3665-8f22-473e-84a8-98b6159c8667	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
25be3665-8f22-473e-84a8-98b6159c8667	90125165-0499-4bec-88d9-e7158d7a3990	f
443f53e9-45e1-4bd3-a462-bd257a953687	4d834829-0d7d-465d-b5df-f981b193abd1	t
443f53e9-45e1-4bd3-a462-bd257a953687	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
443f53e9-45e1-4bd3-a462-bd257a953687	0d392f78-68e2-4b6c-9661-04aedde04310	t
443f53e9-45e1-4bd3-a462-bd257a953687	8715b8e4-7312-486f-87eb-0c798bdc64be	t
443f53e9-45e1-4bd3-a462-bd257a953687	db8181c1-1294-49bb-8188-90dc59ee4d73	t
443f53e9-45e1-4bd3-a462-bd257a953687	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
443f53e9-45e1-4bd3-a462-bd257a953687	920ec61c-7718-4516-a4ef-408c702eae0d	f
443f53e9-45e1-4bd3-a462-bd257a953687	cd55ae5e-4223-4f84-84d6-09ee06553663	f
443f53e9-45e1-4bd3-a462-bd257a953687	371436c2-48f3-4c45-b871-e976cd7d5040	f
443f53e9-45e1-4bd3-a462-bd257a953687	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
443f53e9-45e1-4bd3-a462-bd257a953687	90125165-0499-4bec-88d9-e7158d7a3990	f
972a6183-c205-4fcf-8ac3-649e22dd4a40	4d834829-0d7d-465d-b5df-f981b193abd1	t
972a6183-c205-4fcf-8ac3-649e22dd4a40	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
972a6183-c205-4fcf-8ac3-649e22dd4a40	0d392f78-68e2-4b6c-9661-04aedde04310	t
972a6183-c205-4fcf-8ac3-649e22dd4a40	8715b8e4-7312-486f-87eb-0c798bdc64be	t
972a6183-c205-4fcf-8ac3-649e22dd4a40	db8181c1-1294-49bb-8188-90dc59ee4d73	t
972a6183-c205-4fcf-8ac3-649e22dd4a40	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
972a6183-c205-4fcf-8ac3-649e22dd4a40	920ec61c-7718-4516-a4ef-408c702eae0d	f
972a6183-c205-4fcf-8ac3-649e22dd4a40	cd55ae5e-4223-4f84-84d6-09ee06553663	f
972a6183-c205-4fcf-8ac3-649e22dd4a40	371436c2-48f3-4c45-b871-e976cd7d5040	f
972a6183-c205-4fcf-8ac3-649e22dd4a40	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
972a6183-c205-4fcf-8ac3-649e22dd4a40	90125165-0499-4bec-88d9-e7158d7a3990	f
5098521b-57a9-4016-ba7f-4d03d33341aa	4d834829-0d7d-465d-b5df-f981b193abd1	t
5098521b-57a9-4016-ba7f-4d03d33341aa	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
5098521b-57a9-4016-ba7f-4d03d33341aa	0d392f78-68e2-4b6c-9661-04aedde04310	t
5098521b-57a9-4016-ba7f-4d03d33341aa	8715b8e4-7312-486f-87eb-0c798bdc64be	t
5098521b-57a9-4016-ba7f-4d03d33341aa	db8181c1-1294-49bb-8188-90dc59ee4d73	t
5098521b-57a9-4016-ba7f-4d03d33341aa	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
5098521b-57a9-4016-ba7f-4d03d33341aa	920ec61c-7718-4516-a4ef-408c702eae0d	f
5098521b-57a9-4016-ba7f-4d03d33341aa	cd55ae5e-4223-4f84-84d6-09ee06553663	f
5098521b-57a9-4016-ba7f-4d03d33341aa	371436c2-48f3-4c45-b871-e976cd7d5040	f
5098521b-57a9-4016-ba7f-4d03d33341aa	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
5098521b-57a9-4016-ba7f-4d03d33341aa	90125165-0499-4bec-88d9-e7158d7a3990	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
5a6c03cd-c40c-4452-8d15-0461d47fd31d	df2007fc-3285-4515-a76a-1c894154e99e
920ec61c-7718-4516-a4ef-408c702eae0d	3ce36f7f-7bce-40dd-b547-cea57148ff31
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
d3259b27-a1bd-40b9-837f-96689ed78a9e	Trusted Hosts	68d4a947-cff1-493f-8942-868a60f3a7a4	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	anonymous
e81ee4bd-6b0b-415c-a927-fc09b7394e1a	Consent Required	68d4a947-cff1-493f-8942-868a60f3a7a4	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	anonymous
32a7a0ab-c7b1-452a-a511-5c419ac78e90	Full Scope Disabled	68d4a947-cff1-493f-8942-868a60f3a7a4	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	anonymous
b749582b-5574-4613-9439-73e6c5d84422	Max Clients Limit	68d4a947-cff1-493f-8942-868a60f3a7a4	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	anonymous
717696ba-7591-49cb-b741-9f23fe497ff1	Allowed Protocol Mapper Types	68d4a947-cff1-493f-8942-868a60f3a7a4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	anonymous
7ad78285-a93a-47e5-a5a4-394156f80044	Allowed Client Scopes	68d4a947-cff1-493f-8942-868a60f3a7a4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	anonymous
14143104-ba74-43f1-93f2-ce503add2f9a	Allowed Protocol Mapper Types	68d4a947-cff1-493f-8942-868a60f3a7a4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	authenticated
882a5a21-9590-418c-9bfd-41dfc7526486	Allowed Client Scopes	68d4a947-cff1-493f-8942-868a60f3a7a4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	authenticated
0d0302f7-20fa-4eb4-bb29-7a8d538587f9	rsa-generated	68d4a947-cff1-493f-8942-868a60f3a7a4	rsa-generated	org.keycloak.keys.KeyProvider	68d4a947-cff1-493f-8942-868a60f3a7a4	\N
8c4f4914-62d0-4375-8da5-8a0be209e7f6	rsa-enc-generated	68d4a947-cff1-493f-8942-868a60f3a7a4	rsa-enc-generated	org.keycloak.keys.KeyProvider	68d4a947-cff1-493f-8942-868a60f3a7a4	\N
fa2b4dd9-f4e8-43cf-bb6d-2ae3e455c579	hmac-generated-hs512	68d4a947-cff1-493f-8942-868a60f3a7a4	hmac-generated	org.keycloak.keys.KeyProvider	68d4a947-cff1-493f-8942-868a60f3a7a4	\N
2e3d1a45-e40c-4cec-bbd1-0185a798f459	aes-generated	68d4a947-cff1-493f-8942-868a60f3a7a4	aes-generated	org.keycloak.keys.KeyProvider	68d4a947-cff1-493f-8942-868a60f3a7a4	\N
9945373f-2f5a-4c23-b670-fd15f445a467	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	68d4a947-cff1-493f-8942-868a60f3a7a4	\N
b4eab074-cd65-4338-bbb5-6bc17ef29c1e	rsa-generated	03f0b788-c519-457c-9b1d-cc8412c32a1a	rsa-generated	org.keycloak.keys.KeyProvider	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N
7d24bd65-152c-4c79-88cc-b23bab3e3299	rsa-enc-generated	03f0b788-c519-457c-9b1d-cc8412c32a1a	rsa-enc-generated	org.keycloak.keys.KeyProvider	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N
fe1edc1c-dbcb-410a-a234-d8f91facd29a	hmac-generated-hs512	03f0b788-c519-457c-9b1d-cc8412c32a1a	hmac-generated	org.keycloak.keys.KeyProvider	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N
d9b2395e-c24f-473c-9ef6-0a105689a9c5	aes-generated	03f0b788-c519-457c-9b1d-cc8412c32a1a	aes-generated	org.keycloak.keys.KeyProvider	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N
558f252d-94dc-41d6-8c6c-8fc66cdabaf2	Trusted Hosts	03f0b788-c519-457c-9b1d-cc8412c32a1a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	anonymous
c8e931b5-34b6-42ed-8fd6-6f0948c594d0	Consent Required	03f0b788-c519-457c-9b1d-cc8412c32a1a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	anonymous
5b18898d-9a1a-43a6-875c-850a625dbdb6	Full Scope Disabled	03f0b788-c519-457c-9b1d-cc8412c32a1a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	anonymous
27f778ef-6d74-48a0-802b-6699b027dd21	Max Clients Limit	03f0b788-c519-457c-9b1d-cc8412c32a1a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	anonymous
9a15f7b4-5c73-43d7-a92b-ead500e905e3	Allowed Protocol Mapper Types	03f0b788-c519-457c-9b1d-cc8412c32a1a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	anonymous
e4381d42-8833-47a4-9ebe-e06ee946377b	Allowed Client Scopes	03f0b788-c519-457c-9b1d-cc8412c32a1a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	anonymous
8857c799-8f9f-4903-95e2-acd590f9757a	Allowed Protocol Mapper Types	03f0b788-c519-457c-9b1d-cc8412c32a1a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	authenticated
930a8058-9cc5-4f5c-aff5-0e4b407b992f	Allowed Client Scopes	03f0b788-c519-457c-9b1d-cc8412c32a1a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	authenticated
736ffaa0-4f40-4ec6-a3a9-5477bba026c4	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
d61dc4b7-26ee-46a7-8cf9-7b48c0e3fc6f	7ad78285-a93a-47e5-a5a4-394156f80044	allow-default-scopes	true
de00c656-e62d-4828-9948-90ef7c0fdb6c	d3259b27-a1bd-40b9-837f-96689ed78a9e	client-uris-must-match	true
2c3fbca2-deea-405b-bcea-4e2b73790c57	d3259b27-a1bd-40b9-837f-96689ed78a9e	host-sending-registration-request-must-match	true
1a1fb69a-1dc4-4b27-862e-e75726e9d660	b749582b-5574-4613-9439-73e6c5d84422	max-clients	200
0b73858a-b421-4110-a128-3fb10323f367	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	saml-user-property-mapper
2c3edb3d-ea40-4ed5-803b-5e8facbafdb0	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7a668f45-040b-43aa-9cc6-df2efc345697	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
0faa8a1f-0d36-46ba-97da-9dc3687c8b08	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	oidc-address-mapper
57cb70d2-01ff-41fd-b5f3-7c9aec67d377	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	saml-user-attribute-mapper
55a1c376-afca-4fb8-9bbc-eb0dfa74b068	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	saml-role-list-mapper
5eae9d47-778b-4376-886f-e16a0595c9e1	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1120f7a8-cbd7-4af5-81dc-70760339afca	717696ba-7591-49cb-b741-9f23fe497ff1	allowed-protocol-mapper-types	oidc-full-name-mapper
72c0fa6e-d6db-4271-9289-91356e092863	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	saml-user-attribute-mapper
963cf486-849f-4397-a6b7-91139f193ec8	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
61f4c4a2-6cd0-47cb-9007-3c6f1f289c87	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	saml-user-property-mapper
a6e00531-2a5a-4ecf-b6bb-2847651b1dd2	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	oidc-full-name-mapper
1c3445a0-65ba-4fcd-afd7-305dfc27c968	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	saml-role-list-mapper
fbf3c1a7-91cc-462f-bd48-820664546ff1	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	oidc-address-mapper
39117c4c-048f-41a9-90be-24fe6d07fdda	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8bf5fbc2-fd5e-4da6-a0e0-fa55df0a41f1	14143104-ba74-43f1-93f2-ce503add2f9a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5c48d3b2-911d-4d95-b3fd-170dd193c0e9	882a5a21-9590-418c-9bfd-41dfc7526486	allow-default-scopes	true
79f4802f-5304-41ee-91b2-fc8a3b4413ef	9945373f-2f5a-4c23-b670-fd15f445a467	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
4d71b0d9-068a-4da5-9956-da02f6f6e2b8	0d0302f7-20fa-4eb4-bb29-7a8d538587f9	certificate	MIICmzCCAYMCBgGhM7bInTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYxMDEzMDUyMTE5WhcNMzYxMDEzMDUyMjU5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTJiXq4Hyy4nr1JJuInclku1tFhGX7bTQaCS5qQeDmKjB9ilYa3Eg4Z+mFagIxYFt60JiOPIfnXolkGAmdd2+0e9CUseIuA9WEfHDhQfsC6PJ9/EiWWrr0UPrm11g/om17bTgplqbRdl3mSLQJUzczstiZedNbM6QhnlDSmg+I4xDh4r9LIXNEIp5bjT6lFMUynNRMKCFCsXfBhN7MuPrxB4QUZOLGoFTNaQNtJDsUPBR3PvjLkfMTIeV7LK/U2OZbERor+wG5vJxsBc0S1rmv3nacfeNjTWjq+Hb1O5DILpyCF97mp5RD6qoLkXT20GC16i9b1uhrwOK/1L864NoRAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHtzZohjiynAn5TiPe5sC1EAbRK/xyiThSlpbSEwb6eQuHwQvuOMUXW5MzQDUd4z7nQ5iyGm1n9hdQqjTV1hkA4ePQ1l3v2pJof9VWFxlzxtViKUmftMPIhRQRdz/B//uYb9OhUseZ5Rr2oCvdn9fxyy9KUHMTqUWfM88PoXu+9Jy0nJSGU9qpaSzdWbn6EQxtzkbgWad6HFHkzavvSz+EI8g3RGzLpVrfLnl85IVLcsNbf/32HQaSdhc0dU2BVmAvVE9MsCXymeZWmWfRP2a/Okk3sdoVOvXskZm1aefgZtAH9S6gUgD1rR0LDqD+Neb6YmEsguIXxC6E1zb9Mdix0=
938f3ca8-f248-46a9-8086-bb4941025481	0d0302f7-20fa-4eb4-bb29-7a8d538587f9	priority	100
c8fb9586-d2ed-451a-ad8a-907d45bec0ca	0d0302f7-20fa-4eb4-bb29-7a8d538587f9	privateKey	MIIEogIBAAKCAQEAkyYl6uB8suJ69SSbiJ3JZLtbRYRl+200GgkuakHg5iowfYpWGtxIOGfphWoCMWBbetCYjjyH516JZBgJnXdvtHvQlLHiLgPVhHxw4UH7AujyffxIllq69FD65tdYP6Jte204KZam0XZd5ki0CVM3M7LYmXnTWzOkIZ5Q0poPiOMQ4eK/SyFzRCKeW40+pRTFMpzUTCghQrF3wYTezLj68QeEFGTixqBUzWkDbSQ7FDwUdz74y5HzEyHleyyv1NjmWxEaK/sBubycbAXNEta5r952nH3jY01o6vh29TuQyC6cghfe5qeUQ+qqC5F09tBgteovW9boa8Div9S/OuDaEQIDAQABAoIBACLSKbHhqpCYSJl/LrEPCavlLC2QraNoTaaFmq65ZTOCM1RZ6pNTomF6sYeJNPijQTKYbylliJGHTQLbL1dMfqoajJrLV2clMB84ZWvgtboUDuIiU7kEwm3zRdRfjDoOwVKuX1Z0GIjDtme6t6PnRc5dmaUD77CK0WHFOYIEw/1TxmHga2ZJsQ7pQWz3O26yINDKvFobkoZ3J/BypXYWOnm4Pi4tUTx3r+cWixEtStSE0IV8u7YsZAWTQ9VzlA6okl+cdhKcX08eErJlvKyl3Ya+JBjk2arlIK4o3v3mhDA6X97EoWBwe/3SbC0Gt3tMx8KjDrPHKu4tYfCY2ZzG8sMCgYEAy5ZltyCtKd1NMVqRTJxWxhKS/4WRiDiXkZg4YivkQkqLWOlDjnpHJDr4vCuVgN8ej5JfdByyaBoKnIr5LZvpCu3jjgNQQrJ+hG39BZOfc1xKAeZGmBi8h8xwdJqnZCaeVKWujszRZEpGyAQh/zTXqNV1pnimI3GIe1D4sA4gQXcCgYEAuQggVPQNvTJ30zqAHonVs1estl0xHDAD0op7l12pF5EfC6yet+4kzoHXdAlBE/WmxlkN0T6VBtWczczYMP7UdHGtx5mCoIgZRxqgKhyzdnvtvs2ft4QQPynhCaEDrZ0F6rFT8S0DDgX20IQQyrHQp5PQ3IgS1rNIxNSWgvHx4rcCgYBU59Bb42DUiNrcrmzSipEV4kE0F7xuF0v/CIDbUHrNutEKr53hGdX5oi6CK5saN/NC5USx5BXznIi4aK0q/E7go/23CGK8rjxddpGDdeGV9vNWf3cJj6dw6y4rMySEfCakHsUCASGCtgd2+2JCUQNwAjYiy0ZemcbVxxswMXP6WQKBgEGyHfCr2njzg1HvMnAlVkff+EWjnv04GxNU8f7TVWc1soUtnAkIN+9OcJYVdxLEJJvGIL7LbpRHoe38LkJvKDXT6vS0j4m56OezD20EVb/azpXxYiUBcddLYkhN8AVjfCdRING/vpbrDTAJxACD0+a79+tlMPMkItEn/eyuRMjPAoGAYjI8myHGI4SXaf+nnAcLHcR+FzT4b7n60a27LM/z9Wa28FVWA4HLNAfjwBi7nYRzdT3zQW/Z/RatGwnJ7/hDWDmVg7pQ4V7YkHX94Lgr4T4MLJaPT4P49ckK/cPkKu11nZNexgc+zupmiySFxy5PsqXEEhEwJpWW2hPvdkiQ5Yo=
20ca13c5-2fdb-4391-8fbe-2e74965a6e22	0d0302f7-20fa-4eb4-bb29-7a8d538587f9	keyUse	SIG
7c3d9790-05ef-4c8f-a730-9b11f63065d3	fa2b4dd9-f4e8-43cf-bb6d-2ae3e455c579	priority	100
dfdc4f1e-5089-49c7-bae8-c7d20f0270ad	fa2b4dd9-f4e8-43cf-bb6d-2ae3e455c579	algorithm	HS512
7e99eb26-0edb-4c46-969a-ebedb6f94841	fa2b4dd9-f4e8-43cf-bb6d-2ae3e455c579	kid	24d54a29-83ea-45ba-9158-74988461e4c1
1f9030fc-adff-490c-9c7f-a6f6058d9666	fa2b4dd9-f4e8-43cf-bb6d-2ae3e455c579	secret	UrUadiYI3leg1VpU1O12mqadEpgI7D4RXsPwvuUcNU7R3cJmOpRri_TyV3OWu1Ybs6YJh7UUx61fJCv-Y8G2PzIp4ymnnGdAK2PJ4wKAfmugNiHH_ka2SGNGL3px5qBCXl-KHSwVv_UoN6-jxhSUvKbODJmi7xEQ4ipy2y1Vlzw
56dd8782-ad29-4e2d-8034-1fedfa05bee5	8c4f4914-62d0-4375-8da5-8a0be209e7f6	algorithm	RSA-OAEP
5f6e0d27-dfbb-4f67-80df-69b179002df6	8c4f4914-62d0-4375-8da5-8a0be209e7f6	privateKey	MIIEowIBAAKCAQEA9BWhZHx1Lw2QZWqZ/YfergpOipThbYDjAiSz/QoY1956wdeo/a7Vasq/L2JFsHDmsRPASIhxaxRLnse17cjNFA5XNlK9K6Y99+E2FGqEzQ8RnxxMi7w86CJgL2dNgaUb2v74X0QsDP9decsiKQ1VA7sJE0HPiA7MH+4GWoMrWCk6QGvIE4dR3kohtyhgSiQnOJoiAml2U5shaHsKpewmi9HBUGM5HDP4+CVt6E8W/CGHWhDx5D+UlbYqUJZVpFBSRyV8pEt78m+Gj7ebodegjzyUAcibvfiDHXWR+0p3cwVNvEwKy7ZDG5rgc5uBkoxkmOPGauQ+WdHHjBCJU1Q1iQIDAQABAoIBABr5LHaUt+T5ImLIvOd6/Tldt3gCU6akooGNQYw2MlBhvE5hWSIesOQ+L1JK0YF5+o5pTLufQ2xmR+SONJ1ITlx36LyeuFvDYW/8Ffw72Lzp/EQpbg6XoOH00Y0PhQ3Ni5ZgDJ3HhHgzvLZdw8LGX8WbpNk5Ubg7DWT+anqUagTyAycD3mVGw2Ne5ShRroYqehzz+FdRVVhLSNi8U16wKt1FwiKsv9vcIm58eJCn9RaShzCsDNs+/Wx6W45ujXfNEK2ga0Nt9eqQRRzkY7RQdspaH0zgZ4aS72Wh0UaHx2mrnOQWVAJfJXdWD5ejNdR5D7ItCAgtLSyqnbtjuG6HUWECgYEA/G8noakfuxSd1J+BErH/AHXPp4j+RrVUt/bN8ITOPvc9FZQb2pmkoFp77RAYFw84oTCd8T1dta0xwVgdRBxKpOSVDUotQSw05ns4wM6phKYDNUOfGvkHVYEs+FEorYE/2JZXBt7rrbhodOz0UcqzHJfPQn3aZI6/JPWXhL2ldOkCgYEA94hIG5OVU8po5Zd50P7KNKRGNNjgma2sU7sqmqgpI4uQExJnFWPJJrErJtqpcAClsbQayZHp1MhHeD5mVDlZxjEzzmcGd98ll3r/s7FDO/tuYIzNCG3vgS2w+LOm3GtyBsXiNQCaQGUeNm1Pu82q0d+NxshoGxOrtg0CBbqm16ECgYAmt9XYUdxwEWVz61MczvhR1cAX7kcyCTYJUW2c6oHH3pwb5y+ug8pgXgCMB9/qCYeiEZboHYV2DC6JfT5f6Ab666SA+VOfn2wtvdCiohAWLHBphwmsVW3ui3WeULRwiFaGneiTQTXc22AKLx36PaDjTdWYWT1aFxryTEkFLyFloQKBgGtStGj4eTNGPGrnXVLHVeazHxmEuwUGrwPyz8sUhBm8RjButzEn/av//wSuo+5C6ZR90Wt6D1dJquswqu9zmj/7T0n7k2tf3g2qr7k6bztPjZDhG3i/KavpoqSCSCOjlmHnZGe0piyrawkQJhT4XEr40aDRfYnX4ohhZXIUdohhAoGBAJMj4cMtcvF15Ytftqm/7y/TPQfgHgFFfGU0sN/q4wpFVoBN+qq4KfJpbVN25NQQa1rqEbeoja4aYlqH4I1ZBRVpdpStElIpT6np4TSXpt6papqAXM+g65Xf41oaO3sy9oMsxVI7Fyb+0oZ5UXuLug4f6PxOGac5nxVt1mzS37L1
af90fcc2-f316-4729-8f9a-f9ffc9e4133f	8c4f4914-62d0-4375-8da5-8a0be209e7f6	priority	100
aae9ecf5-c50d-4a18-9400-67be4b6e0f88	8c4f4914-62d0-4375-8da5-8a0be209e7f6	keyUse	ENC
84539371-7f61-411f-aab7-ed44800020c8	8c4f4914-62d0-4375-8da5-8a0be209e7f6	certificate	MIICmzCCAYMCBgGhM7bJOjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYxMDEzMDUyMTE5WhcNMzYxMDEzMDUyMjU5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD0FaFkfHUvDZBlapn9h96uCk6KlOFtgOMCJLP9ChjX3nrB16j9rtVqyr8vYkWwcOaxE8BIiHFrFEuex7XtyM0UDlc2Ur0rpj334TYUaoTNDxGfHEyLvDzoImAvZ02BpRva/vhfRCwM/115yyIpDVUDuwkTQc+IDswf7gZagytYKTpAa8gTh1HeSiG3KGBKJCc4miICaXZTmyFoewql7CaL0cFQYzkcM/j4JW3oTxb8IYdaEPHkP5SVtipQllWkUFJHJXykS3vyb4aPt5uh16CPPJQByJu9+IMddZH7SndzBU28TArLtkMbmuBzm4GSjGSY48Zq5D5Z0ceMEIlTVDWJAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALFQjvJ9YKH7/sxvrmhw6IIHgnXOOhO7odvklatWecjp0lx9fa8uAqXrhyJLwbVncJH0MxllYh5RuMHSDl/AnZEYNMYzZdxNm/dnzJlSCuRc9b9I2qmFjpzjXZowM5NfIgy2k6602NyPgoONMAd3A39i2BdNoA52PA0cE1UAfcTloHGJTSmOBZc+sIlotJIKxOmOsBh4g6LMSbTK1tIPdRUH8ypnHzBpunLadmJ5qZi1zINVtUEmj2S9Z/fFKIy5J8zdWKumT4l04I3hnSqCftcI2AbjcA16JzJGNXqvVcDFX31SwJpT2XfZEEeRAkcZIue20gJc0RiRTznLZUycHLY=
ad83641d-478e-44c4-93e3-73525e449e95	2e3d1a45-e40c-4cec-bbd1-0185a798f459	secret	xhfQEbxka7YrhPeLdNtAbg
32f15eec-fd8b-493f-8167-ddf473eccf26	2e3d1a45-e40c-4cec-bbd1-0185a798f459	priority	100
dc1592c5-c43d-4b5e-90e6-20b1ecdd43f5	2e3d1a45-e40c-4cec-bbd1-0185a798f459	kid	cffd68e5-5e1a-4d63-8cdc-476098334160
87bdd532-cdbb-4a38-a2d3-faf32032a927	b4eab074-cd65-4338-bbb5-6bc17ef29c1e	priority	100
fd897b6a-f055-4154-8103-c3c9ce503dda	b4eab074-cd65-4338-bbb5-6bc17ef29c1e	privateKey	MIIEpQIBAAKCAQEAtaYqptwLg8992IAF0+DaZpg9fPFRIyYY3z+aOAlwrRj83ILbO6OodrWsH1BLkm1gUqhUsVVeJYCK7FktxVXdrKYTLjSZZ6vLNJ/DOPwDiCeQ6+MpRI3jDu9PgWQwglhaHLxBraPGYJoqLf2ImBh7WhrZaz4hR5cCGtzeo2GyFgoKC/jl7kEBZXFxcgxTnzruICm8T+TH10nJ8b0S4eoBcPZoWrawVDn8ooryG24vpH203VELPVcfdVsFPsbSHGZFW7X2mmgx8Qns/z/35/LD5WzhX9QX0Q8XA8fyzzrzrJhC+cjMrrqYglmaOFu4l3U4EPhlLtBS8+BbFY2XVK/KHwIDAQABAoIBAAOxe7eFzNQiwV/IBpZOwZIJcWKbc3df/Gx5mhSemIRkeCuxm2yEgNXdDsFaPBcfkzBLDOHIJxBjIy/4Bja3brjmbYhoeGADva91uh3r/dRkXY12Qm4K5n10vyyV0WitDDP+XeV+aXeoWsgxmffhs4xa9GW6Tynp95h9OiefQmQxSjYVut8KvIuiHfj2yY9BEeqYVIQ85KvHzY7Au8nV94hhTfokCn7xCa0TAa3KrTrAGnhlq2Yxkz5dsLHfmcY7n12zj/fKh/cDr0POD21nAY+Y8hcQDDVLSW7gPVy14YsUwcROYiMhLCjPCnrcbUTNVCiEW65RWfJ+SS1XYiAGOHUCgYEA90ErNjKtxqRhbJVlfWtO9ynmn9enXPyABPV/bcvMWNXCBYF17gg8V/Ti2L+yqeQJWta59ZeE4Vak0cO1eCNX2cCDSpp6JgYcU+wkBNJWw27HMYCBrd2JdwItAiNTN4npnBnFOe8bGKG9sNSdP6E7ZhqPdnexxKka3V1zWgxhk5UCgYEAvBL0sfxlGplbyj/tiEpHYY6Q5f2WrLfsYdczpY2pWuxPgKNDhLnH7FFOz4bkJtvEhPbn0GosQ1GKSjwXeI1L+c8ViHxT6sSq4O33sLbPl9WNos58JeAF0k96CraeAhMQFgEgNcKKmVY+fGFcRjK5lm9YqQm5i7pxykErJwOm+eMCgYEA5J0JC0/IhYav3eo0sMZrePTxHJIVWVDOPceQT0DEbM8YWmbdV32d7eWraaW12IfUbn1j68RxRLkMJDfErpRfQiNSQcSbdFTqFF6e3yZsur7OxuJ/BPd1hugoHXX0F8IYkhDx3yNJ9nh2H+42hwLZHQsp4uvBHokNIeiqI3SXNBECgYEAlAMzEjQ5eXKCG6yuCpmyjaN+g5JMl4d0ABg2LC9NviHF+84BYB45qdDfflGBktdYVPBfxdUZGq28cOnT6usAhQwlvTFjdZrrhHOjgC6PN8Y4Xo20hLZGvpoPyQipV6aa/UZLjCObokuOh6Kz1QcsqajdlMLzhHTqAqvBA0ZLjdMCgYEAuKSYySXDHsPZ7XKDBjPxflk/aa7HZB4atuIIrOCogOHtXXSvEackDK1pD7Jgr3XxFszS+hANGQydbv8cAGw21WWfMonFQrfGJmuOsu2XitywM6/VHkxU3sGG2CDqkZrDneWZdFyOsFZYfWFPI2V5sI4bSdtBRXszhn0IFpe5K9I=
8fe58ba6-dbd2-4467-9b56-14976cc5e97a	b4eab074-cd65-4338-bbb5-6bc17ef29c1e	keyUse	SIG
2bed4f6e-f785-4e73-bed9-db68a87103df	b4eab074-cd65-4338-bbb5-6bc17ef29c1e	certificate	MIICnTCCAYUCBgGhNCwUxjANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdhcHBsaWVyMB4XDTI2MTAxMzA3MjkyNloXDTM2MTAxMzA3MzEwNlowEjEQMA4GA1UEAwwHYXBwbGllcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALWmKqbcC4PPfdiABdPg2maYPXzxUSMmGN8/mjgJcK0Y/NyC2zujqHa1rB9QS5JtYFKoVLFVXiWAiuxZLcVV3aymEy40mWeryzSfwzj8A4gnkOvjKUSN4w7vT4FkMIJYWhy8Qa2jxmCaKi39iJgYe1oa2Ws+IUeXAhrc3qNhshYKCgv45e5BAWVxcXIMU5867iApvE/kx9dJyfG9EuHqAXD2aFq2sFQ5/KKK8htuL6R9tN1RCz1XH3VbBT7G0hxmRVu19ppoMfEJ7P8/9+fyw+Vs4V/UF9EPFwPH8s8686yYQvnIzK66mIJZmjhbuJd1OBD4ZS7QUvPgWxWNl1Svyh8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAVQQSU4IC8Q9BFvNi10pfY2WVNNCgivOnTisNI9fqsx+/cPTPq1KGidZF/PWtNVuJ6gyO6Kt9D8SBslASShGRuPfUEt4jndFPaLvpLZIWOgYifAaGulNxM/i6iOkSI3FU8ty65O+x1uLyfhhdBkfMXn6jrTAnMgHFZy8RQiY3iqH+godfV7B8znyid9dud32BH5YEHbqmNGcYj7hJjnyvuYi0o84jZWxML4fr/KaBg4+0kZzBcddefsM4NlRxUdDO7FOcHV9DMctm85elvB5OKgyP6Y3YpGiKxpbz+lh9RC/B5ETTNXkPH0bvE4zn9jyZYOAPGy1UtdX8IvpCZd8jYg==
bb17100a-d377-4656-844d-aafafa313bca	d9b2395e-c24f-473c-9ef6-0a105689a9c5	kid	bba007fb-ebf6-4d6b-89d2-ea17c5a57a00
cbbf93f9-785a-404b-a230-1cf51c39daac	d9b2395e-c24f-473c-9ef6-0a105689a9c5	priority	100
2886f11e-7d50-4d0f-bbeb-3087b67c13bf	d9b2395e-c24f-473c-9ef6-0a105689a9c5	secret	JKk8dBRJq3Iqu2-MWy_Yww
e30f1e87-f7cb-458e-95b2-a59e7bb3fde5	736ffaa0-4f40-4ec6-a3a9-5477bba026c4	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
31e48a41-02b2-4b67-b4fc-bfb5831d26f0	7d24bd65-152c-4c79-88cc-b23bab3e3299	privateKey	MIIEpAIBAAKCAQEAofjBRY/UzyrKoNrejHwkXdRU44kDGNC3zYxylELKSYfadpa00ntuqqgR+NzP6qLC9Nd1duwean5bV2ufixfjnW1oRGitvOETU82GHokoJ4VXqT5GYSbnxGUX945Xo8zjeZudCVEW/pMDcG+6snnO1s6XJYlckUFOP7pv1yX3ia4JN1OyBFiPvxSCv+ZLxfkfptcwaxxOajZQ9Z7gWKbEerqM0Gt6+28gsLbBeMkoxTqrI+urOPCakXPK2arZ2hUgltj2AY3yCaYg3UJPdO7bPrqrCpsg/8qz8IKOiYrppX5XF+BNKBq9DueeQwyPwtu49hTRhwFOCAyzxSa/kpO41wIDAQABAoIBAASPAD2JdUdZYHeTgWT5z3o2kicPQZ+OrEWkOMtUb+YO5UamKjOsVqqF7W+QI2fqqcsDT2KH9bkwkjiNJmHfS8AwBpm6Sn2A5i7bH3W3jYJDPfrc7lUop6g+4iRNBMlu6E4RY6OR/TAwCg49jsccJ4ajLNzZF1pdOKsRf7lR77wXtt/odGmZ2Pm4SoQQGIVojGjRkRlsjUnKWhpCAypEljy/GwwmivzEatotdNQIFwPP2D9+hCavMDFk3/zv6NL9QCnxN5lDTTxkJsrpDBiYRin7YPkgUzOU/H8ztMGjmKMXuB8YZ8pBmQtyp58jJNfRM8Zc15DeUKz/P5FBGf7OHVECgYEA1cDteNsmOSFHfxS9UsYxuY6FfIIVfWjTpwq9nih44vWqHOJAUJPmRfhoZEl1FPF0nICNwD9aYLysmk4GIH0mDE7fT5kd2Ip7GfBsltRaczVXhoVycem9YQwNBgruBN+Cr9mo/8R5UPuKJ1PcQsw4rGSi/9jpSsY6oQV6c8LZqPECgYEAwfve24nl2pjn+fk26NRT4W3jGQVRqipytX3GNHp3gkNMj/ScH1PW6GCvp9spvV/DjPXXaMLbJxU8sUza0Pi3ZxzT5KiSumXseeenBGMuxoSO7/yvnNkYw1s8bSybmzAb0rXZomBQrGYgUUgMJffy+t0ABTYx5B/lkH41qiIDvkcCgYEAvFiSJwLbbE2hpR2OMOiImhs2Dd7FtspubOru5/R7iGi1K1xFFXss1Yyr12pOq1SSzvALd1Gbfk/hutlzVp9Prlq1NHsTrGFhVRrfZAvbY1amN9dQX4V5JJEszJ1G265ihjbBThU+XJg4RK0FESrH6UeHxO7JqeR/drDQFD6l8dECgYEAlDPwId6LA6WKpcqnDt8ZbsNbm8Qajl174flDsthV8emk1t7VYIHXURZ9XUrt6sb9SfaRKnKkqIlrIzJKgxliVZ8KrEm2QD6amtBHI+z60aR46BUvvi+G4coUsnxALiJlP2i763iWagBkdHUNAv0aYFr0JwcuutE7vFcQfPkbzwUCgYALe1xPBPVvKYL5BnhqkCjOPWGLZGkl6CtcMrq3EP8PdOp7dsJMqFzGFamUNDcF5OSvjj3/sEy5oiBUXue4hMhUdn36UWLzu/Q7KbeH6OYETqO7M+FEtabrbFMXX5E+bHqYMhP8mGRFabYCnWc2mkWRb+2tJaTqWgLT4hnwEOWtqQ==
38406ee5-26ac-41b0-b38d-90d1abca0b23	7d24bd65-152c-4c79-88cc-b23bab3e3299	algorithm	RSA-OAEP
f3028bd5-9903-4ac6-ac13-a3d1918e2bf4	7d24bd65-152c-4c79-88cc-b23bab3e3299	certificate	MIICnTCCAYUCBgGhNCwV/TANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdhcHBsaWVyMB4XDTI2MTAxMzA3MjkyNloXDTM2MTAxMzA3MzEwNlowEjEQMA4GA1UEAwwHYXBwbGllcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKH4wUWP1M8qyqDa3ox8JF3UVOOJAxjQt82McpRCykmH2naWtNJ7bqqoEfjcz+qiwvTXdXbsHmp+W1drn4sX451taERorbzhE1PNhh6JKCeFV6k+RmEm58RlF/eOV6PM43mbnQlRFv6TA3BvurJ5ztbOlyWJXJFBTj+6b9cl94muCTdTsgRYj78Ugr/mS8X5H6bXMGscTmo2UPWe4FimxHq6jNBrevtvILC2wXjJKMU6qyPrqzjwmpFzytmq2doVIJbY9gGN8gmmIN1CT3Tu2z66qwqbIP/Ks/CCjomK6aV+VxfgTSgavQ7nnkMMj8LbuPYU0YcBTggMs8Umv5KTuNcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAO/EGbcmnUJ7cTJId1h1kINUCDQn0ZuEd2uOcIBnlhFjaRNkvpXiZuVAr/0WkfmWLmuOiFSf51LJYdIlc5fhC6LbJFVS5SqR0GnSfjXBPEnfz9kqoAe6kMUrmwAmXyeJni9ATSMEj7T25eodta0AEQJGa11ilh4gz4+JCRDBFUfpkD8YIG2DSzfR8Lz3N6cx2p6WwzjK4Rf5vOv3m33fFb1GQ509a6PGNWk1ChjQi2p1R2ugZKL6RtuHkDWbX1fy8X6kwB1XVH8+5Ue3Xn5R/vRlAn2adgJwoZb/UCZC4B//iu+NSVvJWtJ+YUnbgtPp5Cqdtaphs8GHKe7Zf/9gu/w==
f3c3d046-3f38-4f28-ac0b-1f5effe7793a	7d24bd65-152c-4c79-88cc-b23bab3e3299	priority	100
9724949f-0771-4565-a235-6f03bdbee533	7d24bd65-152c-4c79-88cc-b23bab3e3299	keyUse	ENC
be5d939f-c33b-4d36-96a2-b5d00b935585	fe1edc1c-dbcb-410a-a234-d8f91facd29a	priority	100
68e3d932-61f4-48e1-8940-cffbc4c6f42e	fe1edc1c-dbcb-410a-a234-d8f91facd29a	kid	d3468540-8aa3-46aa-aeee-6c3966cc478f
3e935f39-c9e4-4a0b-91df-1a14df3fc8e9	fe1edc1c-dbcb-410a-a234-d8f91facd29a	algorithm	HS512
b6f33e06-374c-4a5a-a147-2e6e2679411b	fe1edc1c-dbcb-410a-a234-d8f91facd29a	secret	VbqpeZrGvFOmWBeiziHtZlSfj6PjKtTAQzXYlCToxEUqRsM6tM8TLBr6uf--2ebnxcKFMcyNYoj5-TM3z0Rou0QiFAjBcM5_tEx-bRWI1qn2FhAK6tg6Fn4nw0IRHDAw85KfId9E0fUBm7QtqjMiWpzYBIXqn8U32iGAGAFaCN0
ea5f90ab-b0c4-4f89-83d9-29269b25728f	27f778ef-6d74-48a0-802b-6699b027dd21	max-clients	200
282eaaa1-cb4c-4aa0-bc8c-93dd6e6633b2	558f252d-94dc-41d6-8c6c-8fc66cdabaf2	host-sending-registration-request-must-match	true
a9e52b9f-0b8c-4287-b36f-60296a2dc9a5	558f252d-94dc-41d6-8c6c-8fc66cdabaf2	client-uris-must-match	true
cf63af4e-041b-4d85-b1f6-74db206ae639	e4381d42-8833-47a4-9ebe-e06ee946377b	allow-default-scopes	true
6599e04b-f2cb-4eec-94a9-b752c3b79348	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	oidc-address-mapper
7f0cc5f6-64e0-48fd-a532-475b2d64f697	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f50d9c97-73e0-43ee-8775-e81dba1cbc1d	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
67b31e92-76bb-408d-bb49-e1833726b976	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f891a48d-0295-4f05-9825-f125666dc365	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	saml-user-property-mapper
d978f179-cc8d-4ed2-a30d-039c18357c1b	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	saml-user-attribute-mapper
e5d629b5-f4d5-4c83-b55f-186a2baa0f8a	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	oidc-full-name-mapper
4afd9a7c-b61c-4c00-bdd6-67f74563880d	8857c799-8f9f-4903-95e2-acd590f9757a	allowed-protocol-mapper-types	saml-role-list-mapper
d707a22f-ab53-41ff-90f4-9ed81c8fa7c3	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	saml-user-property-mapper
7036000c-3f93-4f96-9808-53b29c21947e	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	oidc-full-name-mapper
dd6f72af-459f-4e6b-ae55-ec9a33b9a952	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	oidc-address-mapper
0300017c-f35b-4175-92fc-51bc24520591	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	saml-role-list-mapper
c4921a67-28df-460c-b177-c9749cc33076	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5ff472de-8e01-4eb3-9c31-5d63311c1348	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f6f8b51d-296e-4410-8afc-50ed529b54d6	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e3381f83-e8aa-4e09-82ce-9a583a384571	9a15f7b4-5c73-43d7-a92b-ead500e905e3	allowed-protocol-mapper-types	saml-user-attribute-mapper
2a8684ae-eead-40b4-86e2-70abba27b14d	930a8058-9cc5-4f5c-aff5-0e4b407b992f	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
90be2d91-ef25-4156-ada8-056a2941c5e5	49f1039d-4e94-4916-ae0a-8838184e0219
90be2d91-ef25-4156-ada8-056a2941c5e5	b94fc887-6c32-4290-869a-0c78bdd2c624
90be2d91-ef25-4156-ada8-056a2941c5e5	91fe354d-f4ef-4db4-8bdb-3c6ed9fcc2a1
90be2d91-ef25-4156-ada8-056a2941c5e5	2e06df7a-ca46-4ae1-b574-5229b7de8fec
90be2d91-ef25-4156-ada8-056a2941c5e5	ad9009c2-c22f-444c-bb96-5cac484c19e0
90be2d91-ef25-4156-ada8-056a2941c5e5	6675294c-ee28-4e1d-85e4-022568b325e5
90be2d91-ef25-4156-ada8-056a2941c5e5	d4b70447-f7c2-4ae4-8076-8430a5434858
90be2d91-ef25-4156-ada8-056a2941c5e5	f61f16a3-d32c-4ad2-8711-0faefc2301c5
90be2d91-ef25-4156-ada8-056a2941c5e5	1618682d-8b4c-491a-8410-643e2bf5d67f
90be2d91-ef25-4156-ada8-056a2941c5e5	06d32124-ee4a-4159-bfd9-09a0c3c0281c
90be2d91-ef25-4156-ada8-056a2941c5e5	a632da42-aafd-4c89-9f78-f3e3fa70e4a6
90be2d91-ef25-4156-ada8-056a2941c5e5	a097c4aa-04ac-4c50-8bd3-a59b49dddd8d
90be2d91-ef25-4156-ada8-056a2941c5e5	9784b89a-1ae9-45cd-b235-758800071d55
90be2d91-ef25-4156-ada8-056a2941c5e5	fa88e048-b208-4ca0-a554-3aec1163b08b
90be2d91-ef25-4156-ada8-056a2941c5e5	6953bb8f-ed2c-4e2e-bd27-a7008b31c418
90be2d91-ef25-4156-ada8-056a2941c5e5	19b2b10c-af92-4637-b00a-1c5b6d2adb72
90be2d91-ef25-4156-ada8-056a2941c5e5	127a080d-53e8-442f-8501-c80c273cfce9
90be2d91-ef25-4156-ada8-056a2941c5e5	af6cf71e-314c-4ea9-b02e-e74ef4ec76ee
2e06df7a-ca46-4ae1-b574-5229b7de8fec	af6cf71e-314c-4ea9-b02e-e74ef4ec76ee
2e06df7a-ca46-4ae1-b574-5229b7de8fec	6953bb8f-ed2c-4e2e-bd27-a7008b31c418
ad9009c2-c22f-444c-bb96-5cac484c19e0	19b2b10c-af92-4637-b00a-1c5b6d2adb72
d829e28b-69ed-47d0-a32b-9409b3f017b0	115e00de-66dd-4cc6-b9bd-ea47d8598a10
d829e28b-69ed-47d0-a32b-9409b3f017b0	42473e7f-b9f3-402d-af1f-c0c8751dd6c9
42473e7f-b9f3-402d-af1f-c0c8751dd6c9	1b467bf1-8567-4ec2-87db-7dec392539c4
b9962cdb-8fd8-468d-aad0-710046d492dc	187139a8-2cc1-4509-ad72-e08d76a55b75
90be2d91-ef25-4156-ada8-056a2941c5e5	ef6aae2d-9086-4495-8de6-d47ab0ca48e0
d829e28b-69ed-47d0-a32b-9409b3f017b0	df2007fc-3285-4515-a76a-1c894154e99e
d829e28b-69ed-47d0-a32b-9409b3f017b0	91c0f3d3-4087-4e3d-8a4e-141b830ef029
90be2d91-ef25-4156-ada8-056a2941c5e5	d0939286-3d47-49ec-a04e-020d43937746
90be2d91-ef25-4156-ada8-056a2941c5e5	d309de50-86f2-4618-be01-e09808c567ef
90be2d91-ef25-4156-ada8-056a2941c5e5	ea51d7cc-2c0b-4f2d-8758-cbe0e186f1ab
90be2d91-ef25-4156-ada8-056a2941c5e5	47f0d615-6647-4c4c-8c65-59ae161d3798
90be2d91-ef25-4156-ada8-056a2941c5e5	1aa53dae-6505-433c-9c24-ea040362686f
90be2d91-ef25-4156-ada8-056a2941c5e5	7bfc2398-f418-41b6-bdbb-7c07d5d4c7a4
90be2d91-ef25-4156-ada8-056a2941c5e5	db76d796-c590-41cf-9894-dcec1b76dc20
90be2d91-ef25-4156-ada8-056a2941c5e5	22951f7c-2695-47e3-b235-7fd93f104cdc
90be2d91-ef25-4156-ada8-056a2941c5e5	c401c4bc-5067-4921-8efe-e6c69102e2f2
90be2d91-ef25-4156-ada8-056a2941c5e5	0cb78b4e-d4f0-4d86-8219-0a5acc1bffc2
90be2d91-ef25-4156-ada8-056a2941c5e5	a25b542c-a476-4c91-8de6-5674483eac80
90be2d91-ef25-4156-ada8-056a2941c5e5	69b4f42f-ec35-4918-b3e6-9503fc581f94
90be2d91-ef25-4156-ada8-056a2941c5e5	d3275a6a-28fc-422d-a3fa-d4bc97e529a7
90be2d91-ef25-4156-ada8-056a2941c5e5	c4205452-248a-4c1a-ad55-7625e361a727
90be2d91-ef25-4156-ada8-056a2941c5e5	8358737d-765a-4ac5-97a0-4ac119715952
90be2d91-ef25-4156-ada8-056a2941c5e5	24588cc1-c8c6-477d-996f-f20791a4c4d2
90be2d91-ef25-4156-ada8-056a2941c5e5	fb04be78-ec2f-4484-9a62-d77f924e7de1
47f0d615-6647-4c4c-8c65-59ae161d3798	8358737d-765a-4ac5-97a0-4ac119715952
ea51d7cc-2c0b-4f2d-8758-cbe0e186f1ab	fb04be78-ec2f-4484-9a62-d77f924e7de1
ea51d7cc-2c0b-4f2d-8758-cbe0e186f1ab	c4205452-248a-4c1a-ad55-7625e361a727
d1846a8b-75c3-4307-9efe-c392036633a9	7cfc11d0-cfef-4f10-ad9c-ce54a0a60243
d1846a8b-75c3-4307-9efe-c392036633a9	4a426aed-a63c-43c0-8b72-8622fcbe5d0e
d1846a8b-75c3-4307-9efe-c392036633a9	b9990188-025e-4ddd-90fd-f94ba12194f3
d1846a8b-75c3-4307-9efe-c392036633a9	6aa36d5a-6e86-4a1c-8e2c-83c4aae70a78
d1846a8b-75c3-4307-9efe-c392036633a9	bdf3ea8b-36d6-481f-b56d-c102a18e134b
d1846a8b-75c3-4307-9efe-c392036633a9	3bf0d300-7099-4406-a95d-045213b4643a
d1846a8b-75c3-4307-9efe-c392036633a9	fcbb9ec4-4c3b-4d13-8290-6959660b66b2
d1846a8b-75c3-4307-9efe-c392036633a9	7a62d957-675b-4b87-b0a9-c28977ba8464
d1846a8b-75c3-4307-9efe-c392036633a9	78b27295-ad68-45a1-8237-2c9795745a08
d1846a8b-75c3-4307-9efe-c392036633a9	35be8360-b304-4069-b1b6-5410c5193287
d1846a8b-75c3-4307-9efe-c392036633a9	07580365-9059-4af6-aa52-299969c64d24
d1846a8b-75c3-4307-9efe-c392036633a9	8c7fffcf-a04a-4779-8c1c-567440bdd96c
d1846a8b-75c3-4307-9efe-c392036633a9	87aee83d-69cd-4e79-975d-56e71891e662
d1846a8b-75c3-4307-9efe-c392036633a9	ab6401dc-56d9-4499-ab87-0219979fd4a1
d1846a8b-75c3-4307-9efe-c392036633a9	60c7719a-cbcb-4d0c-8e3b-017a38da8a2a
d1846a8b-75c3-4307-9efe-c392036633a9	8d66ddc4-5afb-4b45-ac11-1151389ad778
d1846a8b-75c3-4307-9efe-c392036633a9	fa637597-4c60-4a39-bdc8-dd34e6d138f5
6aa36d5a-6e86-4a1c-8e2c-83c4aae70a78	60c7719a-cbcb-4d0c-8e3b-017a38da8a2a
b9990188-025e-4ddd-90fd-f94ba12194f3	ab6401dc-56d9-4499-ab87-0219979fd4a1
b9990188-025e-4ddd-90fd-f94ba12194f3	fa637597-4c60-4a39-bdc8-dd34e6d138f5
f2c1f439-4b26-44a4-8407-fb2f4f9b7b79	0b8d583e-67db-4199-accb-969cde3bea42
f2c1f439-4b26-44a4-8407-fb2f4f9b7b79	e95a2bac-437b-4275-8af2-f710b56f2ae9
e95a2bac-437b-4275-8af2-f710b56f2ae9	40151966-2af9-4990-9c2a-4f95ad7ae1d2
b0be17a9-29af-46b4-af94-ce3b3a135ea9	7da8dc82-d5ed-46bd-be56-803da6537a93
90be2d91-ef25-4156-ada8-056a2941c5e5	c27e98b4-24eb-4030-be37-fba3a7c7b94a
d1846a8b-75c3-4307-9efe-c392036633a9	5370fbef-4ecb-4d7a-ba2a-8605aca4bce9
f2c1f439-4b26-44a4-8407-fb2f4f9b7b79	3ce36f7f-7bce-40dd-b547-cea57148ff31
f2c1f439-4b26-44a4-8407-fb2f4f9b7b79	719aea10-1624-4602-95ae-40623f9ef9d1
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
d5f1d27d-6c34-46d6-8fc0-e3ab694233ff	\N	password	710fbe72-64b9-4b25-8216-7163b3989894	1791868979768	\N	{"value":"XPUirjiUf+VUsxQlCEUsEDq04A1d/8kDzhIBf8fLNaI=","salt":"R0FnK1iBVyXNMPLmFB47aA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
3e9dcd07-0a11-4fce-b3c8-0c5490449321	\N	password	131d6c7c-b654-4088-ac8b-586972c2bc6c	1793065420154	\N	{"value":"OwoiRgmyLI+QHlvO4jw3XdUqBDyhmk5kzPK8uMDN9Ow=","salt":"2pyrHRajclWdqD0D9TiXSw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-10-13 05:22:47.32974	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1868966373
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-10-13 05:22:47.372167	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1868966373
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-10-13 05:22:47.464964	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	1868966373
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-10-13 05:22:47.477285	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1868966373
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-10-13 05:22:47.721872	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1868966373
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-10-13 05:22:47.777727	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1868966373
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-10-13 05:22:48.00442	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1868966373
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-10-13 05:22:48.018664	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1868966373
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-10-13 05:22:48.038366	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	1868966373
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-10-13 05:22:48.289972	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	1868966373
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-10-13 05:22:48.400229	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1868966373
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-10-13 05:22:48.411588	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1868966373
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-10-13 05:22:48.46459	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1868966373
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-10-13 05:22:48.514899	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	1868966373
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-10-13 05:22:48.520631	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-10-13 05:22:48.527339	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	1868966373
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-10-13 05:22:48.534874	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	1868966373
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-10-13 05:22:48.633887	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	1868966373
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-10-13 05:22:48.733299	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1868966373
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-10-13 05:22:48.746259	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1868966373
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-10-13 05:22:48.758995	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1868966373
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-10-13 05:22:48.765675	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1868966373
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-10-13 05:22:48.905335	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	1868966373
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-10-13 05:22:48.920205	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1868966373
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-10-13 05:22:48.925245	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1868966373
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-10-13 05:22:49.633335	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	1868966373
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-10-13 05:22:49.780491	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	1868966373
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-10-13 05:22:49.788517	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1868966373
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-10-13 05:22:49.923515	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	1868966373
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-10-13 05:22:49.959518	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	1868966373
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-10-13 05:22:50.00474	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	1868966373
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-10-13 05:22:50.01594	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	1868966373
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-10-13 05:22:50.031699	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-10-13 05:22:50.038213	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1868966373
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-10-13 05:22:50.099329	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1868966373
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-10-13 05:22:50.112864	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	1868966373
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-10-13 05:22:50.12974	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1868966373
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-10-13 05:22:50.142296	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	1868966373
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-10-13 05:22:50.153862	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	1868966373
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-10-13 05:22:50.158733	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1868966373
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-10-13 05:22:50.165502	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1868966373
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-10-13 05:22:50.176134	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	1868966373
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-10-13 05:22:52.449166	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	1868966373
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-10-13 05:22:52.460395	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	1868966373
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-10-13 05:22:52.485063	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1868966373
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-10-13 05:22:52.494052	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	1868966373
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-10-13 05:22:52.499519	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1868966373
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-10-13 05:22:52.6973	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	1868966373
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-10-13 05:22:52.707818	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	1868966373
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-10-13 05:22:52.803184	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	1868966373
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-10-13 05:22:53.410012	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	1868966373
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-10-13 05:22:53.425834	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-10-13 05:22:53.432844	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	1868966373
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-10-13 05:22:53.439522	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	1868966373
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-10-13 05:22:53.457772	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	1868966373
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-10-13 05:22:53.475461	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	1868966373
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-10-13 05:22:53.560546	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	1868966373
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-10-13 05:22:54.056212	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	1868966373
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-10-13 05:22:54.10231	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	1868966373
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-10-13 05:22:54.120103	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1868966373
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-10-13 05:22:54.142433	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	1868966373
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-10-13 05:22:54.160873	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	1868966373
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-10-13 05:22:54.175869	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1868966373
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-10-13 05:22:54.186289	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1868966373
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-10-13 05:22:54.197047	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	1868966373
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-10-13 05:22:54.300335	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	1868966373
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-10-13 05:22:54.363138	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	1868966373
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-10-13 05:22:54.377542	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	1868966373
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-10-13 05:22:54.453373	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	1868966373
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-10-13 05:22:54.465806	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	1868966373
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-10-13 05:22:54.48201	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1868966373
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-10-13 05:22:54.504638	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1868966373
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-10-13 05:22:54.528671	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1868966373
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-10-13 05:22:54.53743	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1868966373
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-10-13 05:22:54.60031	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	1868966373
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-10-13 05:22:54.66275	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	1868966373
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-10-13 05:22:54.674679	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	1868966373
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-10-13 05:22:54.679355	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	1868966373
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-10-13 05:22:54.724636	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	1868966373
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-10-13 05:22:54.730637	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	1868966373
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-10-13 05:22:54.81912	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	1868966373
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-10-13 05:22:54.82405	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1868966373
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-10-13 05:22:54.834984	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1868966373
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-10-13 05:22:54.839396	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1868966373
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-10-13 05:22:54.883912	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1868966373
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-10-13 05:22:54.911506	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	1868966373
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-10-13 05:22:54.946188	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	1868966373
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-10-13 05:22:54.972885	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	1868966373
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:54.986005	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	1868966373
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.003884	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	1868966373
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.053125	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.075477	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	1868966373
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.080878	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1868966373
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.10408	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1868966373
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.109312	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	1868966373
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-10-13 05:22:55.123884	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	1868966373
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.291123	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.295818	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.311311	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.371347	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.376576	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.433854	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	1868966373
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-10-13 05:22:55.443209	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	1868966373
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-10-13 05:22:55.457538	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	1868966373
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-10-13 05:22:55.519887	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	1868966373
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-10-13 05:22:55.585872	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1868966373
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-10-13 05:22:55.661316	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	1868966373
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-10-13 05:22:55.669991	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	1868966373
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-10-13 05:22:55.723073	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1868966373
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-10-13 05:22:55.728047	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1868966373
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-10-13 05:22:55.741703	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-10-13 05:22:55.749448	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	1868966373
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-10-13 05:22:55.81107	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1868966373
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-10-13 05:22:55.817511	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	1868966373
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-10-13 05:22:55.82664	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	1868966373
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-10-13 05:22:55.832209	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	1868966373
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-10-13 05:22:55.84667	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	1868966373
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-10-13 05:22:55.858478	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1868966373
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-10-13 05:22:56.041495	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	1868966373
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-10-13 05:22:56.049224	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	1868966373
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-10-13 05:22:56.057494	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-10-13 05:22:56.101515	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-10-13 05:22:56.109743	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	1868966373
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-10-13 05:22:56.11499	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-10-13 05:22:56.120796	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.133999	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.198265	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.272088	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.332332	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.391995	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.43541	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.440294	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.494303	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1868966373
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.539734	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1868966373
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.56433	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1868966373
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.569384	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1868966373
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-10-13 05:22:56.666663	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	1868966373
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.684126	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	1868966373
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.698831	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	1868966373
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.75028	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1868966373
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.76326	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	1868966373
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.780225	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1868966373
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.8442	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1868966373
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.935951	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	1868966373
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:56.976423	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1868966373
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:57.011035	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	1868966373
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-10-13 05:22:57.022083	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	1868966373
26.0.6-34013	keycloak	META-INF/jpa-changelog-26.0.6.xml	2026-10-13 05:22:57.03572	148	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1868966373
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
68d4a947-cff1-493f-8942-868a60f3a7a4	5a6c03cd-c40c-4452-8d15-0461d47fd31d	f
68d4a947-cff1-493f-8942-868a60f3a7a4	751dbbcb-c23b-410b-b775-794579d803ac	t
68d4a947-cff1-493f-8942-868a60f3a7a4	50a32981-6b0e-4554-81a0-f3e42d21f57e	t
68d4a947-cff1-493f-8942-868a60f3a7a4	7c62a1af-f66d-466f-9026-e91675699943	t
68d4a947-cff1-493f-8942-868a60f3a7a4	6b300b86-f1b2-4adb-b409-7ab72fccd793	t
68d4a947-cff1-493f-8942-868a60f3a7a4	efe74689-67ce-4d03-9f2d-575310ba3b4c	f
68d4a947-cff1-493f-8942-868a60f3a7a4	9f4720c6-15fe-46c1-88c7-0a81b7602f25	f
68d4a947-cff1-493f-8942-868a60f3a7a4	83f083d9-ace0-4e0f-8274-d1009d869f7a	t
68d4a947-cff1-493f-8942-868a60f3a7a4	2e359507-360b-4260-9309-95c709fd5cb8	t
68d4a947-cff1-493f-8942-868a60f3a7a4	22ce36dc-337b-4ac1-835d-1142550f2204	f
68d4a947-cff1-493f-8942-868a60f3a7a4	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6	t
68d4a947-cff1-493f-8942-868a60f3a7a4	5674f905-4e9c-4b68-ae9d-47786d56ab0a	t
68d4a947-cff1-493f-8942-868a60f3a7a4	9d00ab33-c436-4328-94fb-ec92697c3859	f
03f0b788-c519-457c-9b1d-cc8412c32a1a	920ec61c-7718-4516-a4ef-408c702eae0d	f
03f0b788-c519-457c-9b1d-cc8412c32a1a	08c28948-e0f7-4b3c-98eb-5dd29cd4d4ec	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	8949d8f9-0655-4b31-8191-126408ff07b3	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	6390e957-2228-4f3e-96a7-7cdfe1736b55	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	16ad216f-2f33-4851-b1cc-293a7b7c8ad6	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	371436c2-48f3-4c45-b871-e976cd7d5040	f
03f0b788-c519-457c-9b1d-cc8412c32a1a	cd55ae5e-4223-4f84-84d6-09ee06553663	f
03f0b788-c519-457c-9b1d-cc8412c32a1a	4d834829-0d7d-465d-b5df-f981b193abd1	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	8715b8e4-7312-486f-87eb-0c798bdc64be	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	11441a96-9d9a-49fe-b6b0-de0af5ce54d9	f
03f0b788-c519-457c-9b1d-cc8412c32a1a	0d392f78-68e2-4b6c-9661-04aedde04310	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	db8181c1-1294-49bb-8188-90dc59ee4d73	t
03f0b788-c519-457c-9b1d-cc8412c32a1a	90125165-0499-4bec-88d9-e7158d7a3990	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
d829e28b-69ed-47d0-a32b-9409b3f017b0	68d4a947-cff1-493f-8942-868a60f3a7a4	f	${role_default-roles}	default-roles-master	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	\N
49f1039d-4e94-4916-ae0a-8838184e0219	68d4a947-cff1-493f-8942-868a60f3a7a4	f	${role_create-realm}	create-realm	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	\N
90be2d91-ef25-4156-ada8-056a2941c5e5	68d4a947-cff1-493f-8942-868a60f3a7a4	f	${role_admin}	admin	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	\N
b94fc887-6c32-4290-869a-0c78bdd2c624	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_create-client}	create-client	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
91fe354d-f4ef-4db4-8bdb-3c6ed9fcc2a1	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_view-realm}	view-realm	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
2e06df7a-ca46-4ae1-b574-5229b7de8fec	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_view-users}	view-users	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
ad9009c2-c22f-444c-bb96-5cac484c19e0	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_view-clients}	view-clients	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
6675294c-ee28-4e1d-85e4-022568b325e5	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_view-events}	view-events	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
d4b70447-f7c2-4ae4-8076-8430a5434858	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_view-identity-providers}	view-identity-providers	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
f61f16a3-d32c-4ad2-8711-0faefc2301c5	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_view-authorization}	view-authorization	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
1618682d-8b4c-491a-8410-643e2bf5d67f	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_manage-realm}	manage-realm	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
06d32124-ee4a-4159-bfd9-09a0c3c0281c	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_manage-users}	manage-users	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
a632da42-aafd-4c89-9f78-f3e3fa70e4a6	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_manage-clients}	manage-clients	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
a097c4aa-04ac-4c50-8bd3-a59b49dddd8d	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_manage-events}	manage-events	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
9784b89a-1ae9-45cd-b235-758800071d55	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_manage-identity-providers}	manage-identity-providers	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
fa88e048-b208-4ca0-a554-3aec1163b08b	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_manage-authorization}	manage-authorization	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
6953bb8f-ed2c-4e2e-bd27-a7008b31c418	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_query-users}	query-users	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
19b2b10c-af92-4637-b00a-1c5b6d2adb72	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_query-clients}	query-clients	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
127a080d-53e8-442f-8501-c80c273cfce9	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_query-realms}	query-realms	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
af6cf71e-314c-4ea9-b02e-e74ef4ec76ee	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_query-groups}	query-groups	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
115e00de-66dd-4cc6-b9bd-ea47d8598a10	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_view-profile}	view-profile	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
42473e7f-b9f3-402d-af1f-c0c8751dd6c9	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_manage-account}	manage-account	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
1b467bf1-8567-4ec2-87db-7dec392539c4	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_manage-account-links}	manage-account-links	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
72448f90-1487-4fb4-88fb-7c176572178c	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_view-applications}	view-applications	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
187139a8-2cc1-4509-ad72-e08d76a55b75	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_view-consent}	view-consent	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
b9962cdb-8fd8-468d-aad0-710046d492dc	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_manage-consent}	manage-consent	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
f9cc697b-8494-4bd5-a5aa-e2fe7b1d7e4d	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_view-groups}	view-groups	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
b20e3d0d-43d1-4296-bae3-89d6d7539255	0f42204d-a34b-47a3-909a-f719aab1800f	t	${role_delete-account}	delete-account	68d4a947-cff1-493f-8942-868a60f3a7a4	0f42204d-a34b-47a3-909a-f719aab1800f	\N
3e22589c-4954-4740-95c7-efb5be77703a	8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	t	${role_read-token}	read-token	68d4a947-cff1-493f-8942-868a60f3a7a4	8a1cf48a-1f43-4ca3-95c8-cd23c08766e8	\N
ef6aae2d-9086-4495-8de6-d47ab0ca48e0	8fb0377b-b032-4b45-837b-190c9c97c494	t	${role_impersonation}	impersonation	68d4a947-cff1-493f-8942-868a60f3a7a4	8fb0377b-b032-4b45-837b-190c9c97c494	\N
df2007fc-3285-4515-a76a-1c894154e99e	68d4a947-cff1-493f-8942-868a60f3a7a4	f	${role_offline-access}	offline_access	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	\N
91c0f3d3-4087-4e3d-8a4e-141b830ef029	68d4a947-cff1-493f-8942-868a60f3a7a4	f	${role_uma_authorization}	uma_authorization	68d4a947-cff1-493f-8942-868a60f3a7a4	\N	\N
f2c1f439-4b26-44a4-8407-fb2f4f9b7b79	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	${role_default-roles}	default-roles-applier	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N	\N
d0939286-3d47-49ec-a04e-020d43937746	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_create-client}	create-client	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
d309de50-86f2-4618-be01-e09808c567ef	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_view-realm}	view-realm	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
ea51d7cc-2c0b-4f2d-8758-cbe0e186f1ab	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_view-users}	view-users	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
47f0d615-6647-4c4c-8c65-59ae161d3798	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_view-clients}	view-clients	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
1aa53dae-6505-433c-9c24-ea040362686f	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_view-events}	view-events	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
7bfc2398-f418-41b6-bdbb-7c07d5d4c7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_view-identity-providers}	view-identity-providers	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
db76d796-c590-41cf-9894-dcec1b76dc20	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_view-authorization}	view-authorization	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
22951f7c-2695-47e3-b235-7fd93f104cdc	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_manage-realm}	manage-realm	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
c401c4bc-5067-4921-8efe-e6c69102e2f2	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_manage-users}	manage-users	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
0cb78b4e-d4f0-4d86-8219-0a5acc1bffc2	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_manage-clients}	manage-clients	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
a25b542c-a476-4c91-8de6-5674483eac80	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_manage-events}	manage-events	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
69b4f42f-ec35-4918-b3e6-9503fc581f94	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_manage-identity-providers}	manage-identity-providers	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
d3275a6a-28fc-422d-a3fa-d4bc97e529a7	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_manage-authorization}	manage-authorization	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
c4205452-248a-4c1a-ad55-7625e361a727	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_query-users}	query-users	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
8358737d-765a-4ac5-97a0-4ac119715952	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_query-clients}	query-clients	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
24588cc1-c8c6-477d-996f-f20791a4c4d2	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_query-realms}	query-realms	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
fb04be78-ec2f-4484-9a62-d77f924e7de1	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_query-groups}	query-groups	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
d1846a8b-75c3-4307-9efe-c392036633a9	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_realm-admin}	realm-admin	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
7cfc11d0-cfef-4f10-ad9c-ce54a0a60243	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_create-client}	create-client	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
4a426aed-a63c-43c0-8b72-8622fcbe5d0e	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_view-realm}	view-realm	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
b9990188-025e-4ddd-90fd-f94ba12194f3	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_view-users}	view-users	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
6aa36d5a-6e86-4a1c-8e2c-83c4aae70a78	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_view-clients}	view-clients	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
bdf3ea8b-36d6-481f-b56d-c102a18e134b	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_view-events}	view-events	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
3bf0d300-7099-4406-a95d-045213b4643a	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_view-identity-providers}	view-identity-providers	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
fcbb9ec4-4c3b-4d13-8290-6959660b66b2	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_view-authorization}	view-authorization	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
7a62d957-675b-4b87-b0a9-c28977ba8464	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_manage-realm}	manage-realm	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
78b27295-ad68-45a1-8237-2c9795745a08	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_manage-users}	manage-users	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
35be8360-b304-4069-b1b6-5410c5193287	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_manage-clients}	manage-clients	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
07580365-9059-4af6-aa52-299969c64d24	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_manage-events}	manage-events	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
8c7fffcf-a04a-4779-8c1c-567440bdd96c	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_manage-identity-providers}	manage-identity-providers	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
87aee83d-69cd-4e79-975d-56e71891e662	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_manage-authorization}	manage-authorization	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
ab6401dc-56d9-4499-ab87-0219979fd4a1	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_query-users}	query-users	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
60c7719a-cbcb-4d0c-8e3b-017a38da8a2a	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_query-clients}	query-clients	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
8d66ddc4-5afb-4b45-ac11-1151389ad778	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_query-realms}	query-realms	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
fa637597-4c60-4a39-bdc8-dd34e6d138f5	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_query-groups}	query-groups	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
0b8d583e-67db-4199-accb-969cde3bea42	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_view-profile}	view-profile	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
e95a2bac-437b-4275-8af2-f710b56f2ae9	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_manage-account}	manage-account	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
40151966-2af9-4990-9c2a-4f95ad7ae1d2	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_manage-account-links}	manage-account-links	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
916718ef-ebc0-4d18-90cf-497ede46fcfe	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_view-applications}	view-applications	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
7da8dc82-d5ed-46bd-be56-803da6537a93	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_view-consent}	view-consent	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
b0be17a9-29af-46b4-af94-ce3b3a135ea9	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_manage-consent}	manage-consent	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
be6c1d9e-0491-4d89-baac-e1cf67a18fd5	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_view-groups}	view-groups	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
496bc45a-eb35-46d8-a38b-2c11ddb72f7f	2173459a-3937-4744-a323-e9f6ec19f1bc	t	${role_delete-account}	delete-account	03f0b788-c519-457c-9b1d-cc8412c32a1a	2173459a-3937-4744-a323-e9f6ec19f1bc	\N
c27e98b4-24eb-4030-be37-fba3a7c7b94a	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	t	${role_impersonation}	impersonation	68d4a947-cff1-493f-8942-868a60f3a7a4	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	\N
5370fbef-4ecb-4d7a-ba2a-8605aca4bce9	443f53e9-45e1-4bd3-a462-bd257a953687	t	${role_impersonation}	impersonation	03f0b788-c519-457c-9b1d-cc8412c32a1a	443f53e9-45e1-4bd3-a462-bd257a953687	\N
d78a82cc-d69e-4cec-9f44-c7719b49a19a	25be3665-8f22-473e-84a8-98b6159c8667	t	${role_read-token}	read-token	03f0b788-c519-457c-9b1d-cc8412c32a1a	25be3665-8f22-473e-84a8-98b6159c8667	\N
3ce36f7f-7bce-40dd-b547-cea57148ff31	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	${role_offline-access}	offline_access	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N	\N
719aea10-1624-4602-95ae-40623f9ef9d1	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	${role_uma_authorization}	uma_authorization	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N	\N
1306f93d-8086-4ac8-8fa1-fd02e6e1009f	03f0b788-c519-457c-9b1d-cc8412c32a1a	f		Admin	03f0b788-c519-457c-9b1d-cc8412c32a1a	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
zo3p2	26.0.8	1791868977
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
aa933154-9558-4f94-a9ab-9ddf3b77f291	5098521b-57a9-4016-ba7f-4d03d33341aa	0	1793066885	{"authMethod":"openid-connect","redirectUri":"http://localhost:8081/login/oauth2/code/keycloak","notes":{"clientId":"5098521b-57a9-4016-ba7f-4d03d33341aa","userSessionRememberMe":"true","iss":"http://localhost:8080/realms/applier","startedAt":"1793064978","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"EwrYEeDKnKJYqvuOQ-3pbcnnmgPWhxSPstbeHkOZwHE","scope":"openid profile email","userSessionStartedAt":"1793064978","redirect_uri":"http://localhost:8081/login/oauth2/code/keycloak","state":"uiYLY7vJjE91uBlWuF7O65dMH4zhew31k0-NrQ-h3_k=","code_challenge":"oJHQRplZxCMe8qNugEcnTLD1uwWfD0p3CaH1G1rmBCU","SSO_AUTH":"true"}}	local	local	5
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
aa933154-9558-4f94-a9ab-9ddf3b77f291	131d6c7c-b654-4088-ac8b-586972c2bc6c	03f0b788-c519-457c-9b1d-cc8412c32a1a	1793064978	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xNTcuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1793064978","authenticators-completed":"{\\"3e6c4ec8-6807-4262-aaf3-3ab66c0399aa\\":1793064978,\\"1185e718-375c-496a-ad16-8066d5515934\\":1793066884}"},"state":"LOGGED_IN"}	1793066885	\N	5
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
d8ee8f21-7f1a-4357-a974-d3595cb56989	audience resolve	openid-connect	oidc-audience-resolve-mapper	8e23a6ec-a04d-4565-bef0-fa70ba0f698f	\N
7d3e1ec1-b52e-43a0-ae8a-567423426704	locale	openid-connect	oidc-usermodel-attribute-mapper	5bbfe09f-079f-40e6-aa17-33fc2e201325	\N
08ecc890-05d0-483f-ba27-1cd4050643f4	role list	saml	saml-role-list-mapper	\N	751dbbcb-c23b-410b-b775-794579d803ac
3bb62db0-dde3-4e3b-ba9d-feffecbd8aca	organization	saml	saml-organization-membership-mapper	\N	50a32981-6b0e-4554-81a0-f3e42d21f57e
800d5bcd-6981-4944-b024-868f9960c0be	full name	openid-connect	oidc-full-name-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
232b0c94-1662-4985-b038-b07721fec7ea	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
97000efa-9147-422f-a692-6804c8d8a9fd	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
34fd8895-d3fa-45a4-accd-c28afd85e883	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
8146f11b-818a-4922-ac9e-42113e27459c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	username	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
093ee31e-2632-4d7c-b2dd-ee30babee763	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
ec120a1e-8dce-400a-b755-5a1a20193a22	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
de473346-82de-4f9f-adc4-ba9a6e5912d4	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
9f27d6c1-8f20-4e8a-8174-48b803300344	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
60f33ff7-e207-4eb2-82b9-f6424d1f820e	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
729e3a64-6fa9-4486-9112-cf8f6fed0908	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
7ca70404-7d10-42c5-af41-7b895501d2ff	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7c62a1af-f66d-466f-9026-e91675699943
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	email	openid-connect	oidc-usermodel-attribute-mapper	\N	6b300b86-f1b2-4adb-b409-7ab72fccd793
4565dbed-731a-4fc0-8296-d3040d537ce2	email verified	openid-connect	oidc-usermodel-property-mapper	\N	6b300b86-f1b2-4adb-b409-7ab72fccd793
994171f2-d059-4c05-b7f0-008528e13f55	address	openid-connect	oidc-address-mapper	\N	efe74689-67ce-4d03-9f2d-575310ba3b4c
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	9f4720c6-15fe-46c1-88c7-0a81b7602f25
969a440b-0df3-407b-8657-f26aafec0217	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	9f4720c6-15fe-46c1-88c7-0a81b7602f25
b67cb206-4949-4394-8ae6-0c1571dc2520	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	83f083d9-ace0-4e0f-8274-d1009d869f7a
5cc1ed1e-5152-4c9c-9993-96a68feeb292	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	83f083d9-ace0-4e0f-8274-d1009d869f7a
63a9e847-ce10-4af1-9916-49ba0b6aeaec	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	83f083d9-ace0-4e0f-8274-d1009d869f7a
c4e8e133-cdda-4289-9710-2c91e9465b93	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2e359507-360b-4260-9309-95c709fd5cb8
a915e507-0ebb-477f-99e0-294613a94d3f	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	22ce36dc-337b-4ac1-835d-1142550f2204
4dfa1b02-64c8-492a-acd8-5c0c91f27494	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	22ce36dc-337b-4ac1-835d-1142550f2204
46ee8584-ebb1-4424-8d5c-96d61966a29c	acr loa level	openid-connect	oidc-acr-mapper	\N	c2fd8dc2-0a37-4416-b7c8-3f6aa2ebd3e6
5ad5620d-69bb-450a-9785-73ccba83b75d	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	5674f905-4e9c-4b68-ae9d-47786d56ab0a
2662861a-c1ef-491b-a0b4-1a0052129003	sub	openid-connect	oidc-sub-mapper	\N	5674f905-4e9c-4b68-ae9d-47786d56ab0a
466793ed-7a48-4757-8f9b-50181054f5a6	organization	openid-connect	oidc-organization-membership-mapper	\N	9d00ab33-c436-4328-94fb-ec92697c3859
35ef4cb5-72a1-4aee-900e-e2b31b9cdfed	audience resolve	openid-connect	oidc-audience-resolve-mapper	dacefb67-ba86-4048-bcdc-d64b69ba2cf5	\N
d2e212f5-bec0-47b2-a6a8-8be0f6dcc0aa	role list	saml	saml-role-list-mapper	\N	08c28948-e0f7-4b3c-98eb-5dd29cd4d4ec
aaebddc8-8bf9-4576-93d6-62dbcbeb3336	organization	saml	saml-organization-membership-mapper	\N	8949d8f9-0655-4b31-8191-126408ff07b3
b550c0fb-6b50-47d9-90d7-1fd75f090b6e	full name	openid-connect	oidc-full-name-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
20890fef-b10f-4125-8706-c924fd110971	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
bfc74930-dd52-4489-907e-e0d0136a7079	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
c7416992-46b1-4112-8174-ec0cb2e83b65	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
319dcd57-5f83-48e1-9850-a47b152c6f8d	username	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
2f5453a7-786e-49f5-94e7-beca0eda434f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
07efc571-cfa0-4a25-b173-682a04c9deba	website	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
9501e7c4-a147-4829-b21c-0213645ce563	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
9d88c445-5587-4a04-a08b-28651cc7dfd5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
99c65d6b-9e2b-42e5-afc5-228d67f19669	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
d35a3a4b-ede0-4be8-879c-cb109084d752	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	6390e957-2228-4f3e-96a7-7cdfe1736b55
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	email	openid-connect	oidc-usermodel-attribute-mapper	\N	16ad216f-2f33-4851-b1cc-293a7b7c8ad6
133dbff0-1b60-4fec-a735-088586ada99f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	16ad216f-2f33-4851-b1cc-293a7b7c8ad6
e8825953-7fc7-46db-b1e5-33a58b51a739	address	openid-connect	oidc-address-mapper	\N	371436c2-48f3-4c45-b871-e976cd7d5040
12046879-d98c-4608-8197-24f16a997b68	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	cd55ae5e-4223-4f84-84d6-09ee06553663
ac209dda-012a-4fdd-b00b-10c4c305f95c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	cd55ae5e-4223-4f84-84d6-09ee06553663
2409ee90-a6a9-474a-b84d-72f84c52846e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4d834829-0d7d-465d-b5df-f981b193abd1
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4d834829-0d7d-465d-b5df-f981b193abd1
288b0cfd-bf11-41b9-9cf6-fb88145bc016	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4d834829-0d7d-465d-b5df-f981b193abd1
7b7b1108-eec1-4571-adb2-d7dfef52bd1f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8715b8e4-7312-486f-87eb-0c798bdc64be
a9341755-d193-4ff1-a9b5-493814359756	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	11441a96-9d9a-49fe-b6b0-de0af5ce54d9
cae19080-1884-4d38-8c4e-082a4f80e6d1	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	11441a96-9d9a-49fe-b6b0-de0af5ce54d9
e73dfa2d-0dca-44e9-b370-d77bed38bf3a	acr loa level	openid-connect	oidc-acr-mapper	\N	0d392f78-68e2-4b6c-9661-04aedde04310
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	db8181c1-1294-49bb-8188-90dc59ee4d73
1db15c30-cadf-4515-9e78-5cc9344ede52	sub	openid-connect	oidc-sub-mapper	\N	db8181c1-1294-49bb-8188-90dc59ee4d73
1d6e2494-3ad7-48a9-8a03-170629fff4d2	organization	openid-connect	oidc-organization-membership-mapper	\N	90125165-0499-4bec-88d9-e7158d7a3990
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	locale	openid-connect	oidc-usermodel-attribute-mapper	972a6183-c205-4fcf-8ac3-649e22dd4a40	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
7d3e1ec1-b52e-43a0-ae8a-567423426704	true	introspection.token.claim
7d3e1ec1-b52e-43a0-ae8a-567423426704	true	userinfo.token.claim
7d3e1ec1-b52e-43a0-ae8a-567423426704	locale	user.attribute
7d3e1ec1-b52e-43a0-ae8a-567423426704	true	id.token.claim
7d3e1ec1-b52e-43a0-ae8a-567423426704	true	access.token.claim
7d3e1ec1-b52e-43a0-ae8a-567423426704	locale	claim.name
7d3e1ec1-b52e-43a0-ae8a-567423426704	String	jsonType.label
08ecc890-05d0-483f-ba27-1cd4050643f4	false	single
08ecc890-05d0-483f-ba27-1cd4050643f4	Basic	attribute.nameformat
08ecc890-05d0-483f-ba27-1cd4050643f4	Role	attribute.name
093ee31e-2632-4d7c-b2dd-ee30babee763	true	introspection.token.claim
093ee31e-2632-4d7c-b2dd-ee30babee763	true	userinfo.token.claim
093ee31e-2632-4d7c-b2dd-ee30babee763	profile	user.attribute
093ee31e-2632-4d7c-b2dd-ee30babee763	true	id.token.claim
093ee31e-2632-4d7c-b2dd-ee30babee763	true	access.token.claim
093ee31e-2632-4d7c-b2dd-ee30babee763	profile	claim.name
093ee31e-2632-4d7c-b2dd-ee30babee763	String	jsonType.label
232b0c94-1662-4985-b038-b07721fec7ea	true	introspection.token.claim
232b0c94-1662-4985-b038-b07721fec7ea	true	userinfo.token.claim
232b0c94-1662-4985-b038-b07721fec7ea	lastName	user.attribute
232b0c94-1662-4985-b038-b07721fec7ea	true	id.token.claim
232b0c94-1662-4985-b038-b07721fec7ea	true	access.token.claim
232b0c94-1662-4985-b038-b07721fec7ea	family_name	claim.name
232b0c94-1662-4985-b038-b07721fec7ea	String	jsonType.label
34fd8895-d3fa-45a4-accd-c28afd85e883	true	introspection.token.claim
34fd8895-d3fa-45a4-accd-c28afd85e883	true	userinfo.token.claim
34fd8895-d3fa-45a4-accd-c28afd85e883	middleName	user.attribute
34fd8895-d3fa-45a4-accd-c28afd85e883	true	id.token.claim
34fd8895-d3fa-45a4-accd-c28afd85e883	true	access.token.claim
34fd8895-d3fa-45a4-accd-c28afd85e883	middle_name	claim.name
34fd8895-d3fa-45a4-accd-c28afd85e883	String	jsonType.label
60f33ff7-e207-4eb2-82b9-f6424d1f820e	true	introspection.token.claim
60f33ff7-e207-4eb2-82b9-f6424d1f820e	true	userinfo.token.claim
60f33ff7-e207-4eb2-82b9-f6424d1f820e	zoneinfo	user.attribute
60f33ff7-e207-4eb2-82b9-f6424d1f820e	true	id.token.claim
60f33ff7-e207-4eb2-82b9-f6424d1f820e	true	access.token.claim
60f33ff7-e207-4eb2-82b9-f6424d1f820e	zoneinfo	claim.name
60f33ff7-e207-4eb2-82b9-f6424d1f820e	String	jsonType.label
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	true	introspection.token.claim
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	true	userinfo.token.claim
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	website	user.attribute
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	true	id.token.claim
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	true	access.token.claim
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	website	claim.name
6d0e7f8d-d5ed-4e51-a63b-7705fd23c9e2	String	jsonType.label
729e3a64-6fa9-4486-9112-cf8f6fed0908	true	introspection.token.claim
729e3a64-6fa9-4486-9112-cf8f6fed0908	true	userinfo.token.claim
729e3a64-6fa9-4486-9112-cf8f6fed0908	locale	user.attribute
729e3a64-6fa9-4486-9112-cf8f6fed0908	true	id.token.claim
729e3a64-6fa9-4486-9112-cf8f6fed0908	true	access.token.claim
729e3a64-6fa9-4486-9112-cf8f6fed0908	locale	claim.name
729e3a64-6fa9-4486-9112-cf8f6fed0908	String	jsonType.label
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	true	introspection.token.claim
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	true	userinfo.token.claim
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	username	user.attribute
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	true	id.token.claim
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	true	access.token.claim
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	preferred_username	claim.name
7c4abff9-1835-4ad2-87e2-0dcd5619f8f9	String	jsonType.label
7ca70404-7d10-42c5-af41-7b895501d2ff	true	introspection.token.claim
7ca70404-7d10-42c5-af41-7b895501d2ff	true	userinfo.token.claim
7ca70404-7d10-42c5-af41-7b895501d2ff	updatedAt	user.attribute
7ca70404-7d10-42c5-af41-7b895501d2ff	true	id.token.claim
7ca70404-7d10-42c5-af41-7b895501d2ff	true	access.token.claim
7ca70404-7d10-42c5-af41-7b895501d2ff	updated_at	claim.name
7ca70404-7d10-42c5-af41-7b895501d2ff	long	jsonType.label
800d5bcd-6981-4944-b024-868f9960c0be	true	introspection.token.claim
800d5bcd-6981-4944-b024-868f9960c0be	true	userinfo.token.claim
800d5bcd-6981-4944-b024-868f9960c0be	true	id.token.claim
800d5bcd-6981-4944-b024-868f9960c0be	true	access.token.claim
8146f11b-818a-4922-ac9e-42113e27459c	true	introspection.token.claim
8146f11b-818a-4922-ac9e-42113e27459c	true	userinfo.token.claim
8146f11b-818a-4922-ac9e-42113e27459c	nickname	user.attribute
8146f11b-818a-4922-ac9e-42113e27459c	true	id.token.claim
8146f11b-818a-4922-ac9e-42113e27459c	true	access.token.claim
8146f11b-818a-4922-ac9e-42113e27459c	nickname	claim.name
8146f11b-818a-4922-ac9e-42113e27459c	String	jsonType.label
97000efa-9147-422f-a692-6804c8d8a9fd	true	introspection.token.claim
97000efa-9147-422f-a692-6804c8d8a9fd	true	userinfo.token.claim
97000efa-9147-422f-a692-6804c8d8a9fd	firstName	user.attribute
97000efa-9147-422f-a692-6804c8d8a9fd	true	id.token.claim
97000efa-9147-422f-a692-6804c8d8a9fd	true	access.token.claim
97000efa-9147-422f-a692-6804c8d8a9fd	given_name	claim.name
97000efa-9147-422f-a692-6804c8d8a9fd	String	jsonType.label
9f27d6c1-8f20-4e8a-8174-48b803300344	true	introspection.token.claim
9f27d6c1-8f20-4e8a-8174-48b803300344	true	userinfo.token.claim
9f27d6c1-8f20-4e8a-8174-48b803300344	birthdate	user.attribute
9f27d6c1-8f20-4e8a-8174-48b803300344	true	id.token.claim
9f27d6c1-8f20-4e8a-8174-48b803300344	true	access.token.claim
9f27d6c1-8f20-4e8a-8174-48b803300344	birthdate	claim.name
9f27d6c1-8f20-4e8a-8174-48b803300344	String	jsonType.label
de473346-82de-4f9f-adc4-ba9a6e5912d4	true	introspection.token.claim
de473346-82de-4f9f-adc4-ba9a6e5912d4	true	userinfo.token.claim
de473346-82de-4f9f-adc4-ba9a6e5912d4	gender	user.attribute
de473346-82de-4f9f-adc4-ba9a6e5912d4	true	id.token.claim
de473346-82de-4f9f-adc4-ba9a6e5912d4	true	access.token.claim
de473346-82de-4f9f-adc4-ba9a6e5912d4	gender	claim.name
de473346-82de-4f9f-adc4-ba9a6e5912d4	String	jsonType.label
ec120a1e-8dce-400a-b755-5a1a20193a22	true	introspection.token.claim
ec120a1e-8dce-400a-b755-5a1a20193a22	true	userinfo.token.claim
ec120a1e-8dce-400a-b755-5a1a20193a22	picture	user.attribute
ec120a1e-8dce-400a-b755-5a1a20193a22	true	id.token.claim
ec120a1e-8dce-400a-b755-5a1a20193a22	true	access.token.claim
ec120a1e-8dce-400a-b755-5a1a20193a22	picture	claim.name
ec120a1e-8dce-400a-b755-5a1a20193a22	String	jsonType.label
4565dbed-731a-4fc0-8296-d3040d537ce2	true	introspection.token.claim
4565dbed-731a-4fc0-8296-d3040d537ce2	true	userinfo.token.claim
4565dbed-731a-4fc0-8296-d3040d537ce2	emailVerified	user.attribute
4565dbed-731a-4fc0-8296-d3040d537ce2	true	id.token.claim
4565dbed-731a-4fc0-8296-d3040d537ce2	true	access.token.claim
4565dbed-731a-4fc0-8296-d3040d537ce2	email_verified	claim.name
4565dbed-731a-4fc0-8296-d3040d537ce2	boolean	jsonType.label
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	true	introspection.token.claim
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	true	userinfo.token.claim
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	email	user.attribute
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	true	id.token.claim
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	true	access.token.claim
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	email	claim.name
d38b6ec6-e001-42bd-8e7b-4626117ebbc8	String	jsonType.label
994171f2-d059-4c05-b7f0-008528e13f55	formatted	user.attribute.formatted
994171f2-d059-4c05-b7f0-008528e13f55	country	user.attribute.country
994171f2-d059-4c05-b7f0-008528e13f55	true	introspection.token.claim
994171f2-d059-4c05-b7f0-008528e13f55	postal_code	user.attribute.postal_code
994171f2-d059-4c05-b7f0-008528e13f55	true	userinfo.token.claim
994171f2-d059-4c05-b7f0-008528e13f55	street	user.attribute.street
994171f2-d059-4c05-b7f0-008528e13f55	true	id.token.claim
994171f2-d059-4c05-b7f0-008528e13f55	region	user.attribute.region
994171f2-d059-4c05-b7f0-008528e13f55	true	access.token.claim
994171f2-d059-4c05-b7f0-008528e13f55	locality	user.attribute.locality
969a440b-0df3-407b-8657-f26aafec0217	true	introspection.token.claim
969a440b-0df3-407b-8657-f26aafec0217	true	userinfo.token.claim
969a440b-0df3-407b-8657-f26aafec0217	phoneNumberVerified	user.attribute
969a440b-0df3-407b-8657-f26aafec0217	true	id.token.claim
969a440b-0df3-407b-8657-f26aafec0217	true	access.token.claim
969a440b-0df3-407b-8657-f26aafec0217	phone_number_verified	claim.name
969a440b-0df3-407b-8657-f26aafec0217	boolean	jsonType.label
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	true	introspection.token.claim
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	true	userinfo.token.claim
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	phoneNumber	user.attribute
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	true	id.token.claim
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	true	access.token.claim
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	phone_number	claim.name
d5c9ac2a-52ee-4191-80aa-fffc7a5f02ac	String	jsonType.label
5cc1ed1e-5152-4c9c-9993-96a68feeb292	true	introspection.token.claim
5cc1ed1e-5152-4c9c-9993-96a68feeb292	true	multivalued
5cc1ed1e-5152-4c9c-9993-96a68feeb292	foo	user.attribute
5cc1ed1e-5152-4c9c-9993-96a68feeb292	true	access.token.claim
5cc1ed1e-5152-4c9c-9993-96a68feeb292	resource_access.${client_id}.roles	claim.name
5cc1ed1e-5152-4c9c-9993-96a68feeb292	String	jsonType.label
63a9e847-ce10-4af1-9916-49ba0b6aeaec	true	introspection.token.claim
63a9e847-ce10-4af1-9916-49ba0b6aeaec	true	access.token.claim
b67cb206-4949-4394-8ae6-0c1571dc2520	true	introspection.token.claim
b67cb206-4949-4394-8ae6-0c1571dc2520	true	multivalued
b67cb206-4949-4394-8ae6-0c1571dc2520	foo	user.attribute
b67cb206-4949-4394-8ae6-0c1571dc2520	true	access.token.claim
b67cb206-4949-4394-8ae6-0c1571dc2520	realm_access.roles	claim.name
b67cb206-4949-4394-8ae6-0c1571dc2520	String	jsonType.label
c4e8e133-cdda-4289-9710-2c91e9465b93	true	introspection.token.claim
c4e8e133-cdda-4289-9710-2c91e9465b93	true	access.token.claim
4dfa1b02-64c8-492a-acd8-5c0c91f27494	true	introspection.token.claim
4dfa1b02-64c8-492a-acd8-5c0c91f27494	true	multivalued
4dfa1b02-64c8-492a-acd8-5c0c91f27494	foo	user.attribute
4dfa1b02-64c8-492a-acd8-5c0c91f27494	true	id.token.claim
4dfa1b02-64c8-492a-acd8-5c0c91f27494	true	access.token.claim
4dfa1b02-64c8-492a-acd8-5c0c91f27494	groups	claim.name
4dfa1b02-64c8-492a-acd8-5c0c91f27494	String	jsonType.label
a915e507-0ebb-477f-99e0-294613a94d3f	true	introspection.token.claim
a915e507-0ebb-477f-99e0-294613a94d3f	true	userinfo.token.claim
a915e507-0ebb-477f-99e0-294613a94d3f	username	user.attribute
a915e507-0ebb-477f-99e0-294613a94d3f	true	id.token.claim
a915e507-0ebb-477f-99e0-294613a94d3f	true	access.token.claim
a915e507-0ebb-477f-99e0-294613a94d3f	upn	claim.name
a915e507-0ebb-477f-99e0-294613a94d3f	String	jsonType.label
46ee8584-ebb1-4424-8d5c-96d61966a29c	true	introspection.token.claim
46ee8584-ebb1-4424-8d5c-96d61966a29c	true	id.token.claim
46ee8584-ebb1-4424-8d5c-96d61966a29c	true	access.token.claim
2662861a-c1ef-491b-a0b4-1a0052129003	true	introspection.token.claim
2662861a-c1ef-491b-a0b4-1a0052129003	true	access.token.claim
5ad5620d-69bb-450a-9785-73ccba83b75d	AUTH_TIME	user.session.note
5ad5620d-69bb-450a-9785-73ccba83b75d	true	introspection.token.claim
5ad5620d-69bb-450a-9785-73ccba83b75d	true	id.token.claim
5ad5620d-69bb-450a-9785-73ccba83b75d	true	access.token.claim
5ad5620d-69bb-450a-9785-73ccba83b75d	auth_time	claim.name
5ad5620d-69bb-450a-9785-73ccba83b75d	long	jsonType.label
466793ed-7a48-4757-8f9b-50181054f5a6	true	introspection.token.claim
466793ed-7a48-4757-8f9b-50181054f5a6	true	multivalued
466793ed-7a48-4757-8f9b-50181054f5a6	true	id.token.claim
466793ed-7a48-4757-8f9b-50181054f5a6	true	access.token.claim
466793ed-7a48-4757-8f9b-50181054f5a6	organization	claim.name
466793ed-7a48-4757-8f9b-50181054f5a6	String	jsonType.label
d2e212f5-bec0-47b2-a6a8-8be0f6dcc0aa	false	single
d2e212f5-bec0-47b2-a6a8-8be0f6dcc0aa	Basic	attribute.nameformat
d2e212f5-bec0-47b2-a6a8-8be0f6dcc0aa	Role	attribute.name
07efc571-cfa0-4a25-b173-682a04c9deba	true	introspection.token.claim
07efc571-cfa0-4a25-b173-682a04c9deba	true	userinfo.token.claim
07efc571-cfa0-4a25-b173-682a04c9deba	website	user.attribute
07efc571-cfa0-4a25-b173-682a04c9deba	true	id.token.claim
07efc571-cfa0-4a25-b173-682a04c9deba	true	access.token.claim
07efc571-cfa0-4a25-b173-682a04c9deba	website	claim.name
07efc571-cfa0-4a25-b173-682a04c9deba	String	jsonType.label
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	true	introspection.token.claim
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	true	userinfo.token.claim
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	gender	user.attribute
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	true	id.token.claim
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	true	access.token.claim
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	gender	claim.name
0d724ad9-5f88-494e-90a0-ef2b36c71b2b	String	jsonType.label
20890fef-b10f-4125-8706-c924fd110971	true	introspection.token.claim
20890fef-b10f-4125-8706-c924fd110971	true	userinfo.token.claim
20890fef-b10f-4125-8706-c924fd110971	firstName	user.attribute
20890fef-b10f-4125-8706-c924fd110971	true	id.token.claim
20890fef-b10f-4125-8706-c924fd110971	true	access.token.claim
20890fef-b10f-4125-8706-c924fd110971	given_name	claim.name
20890fef-b10f-4125-8706-c924fd110971	String	jsonType.label
2f5453a7-786e-49f5-94e7-beca0eda434f	true	introspection.token.claim
2f5453a7-786e-49f5-94e7-beca0eda434f	true	userinfo.token.claim
2f5453a7-786e-49f5-94e7-beca0eda434f	picture	user.attribute
2f5453a7-786e-49f5-94e7-beca0eda434f	true	id.token.claim
2f5453a7-786e-49f5-94e7-beca0eda434f	true	access.token.claim
2f5453a7-786e-49f5-94e7-beca0eda434f	picture	claim.name
2f5453a7-786e-49f5-94e7-beca0eda434f	String	jsonType.label
319dcd57-5f83-48e1-9850-a47b152c6f8d	true	introspection.token.claim
319dcd57-5f83-48e1-9850-a47b152c6f8d	true	userinfo.token.claim
319dcd57-5f83-48e1-9850-a47b152c6f8d	username	user.attribute
319dcd57-5f83-48e1-9850-a47b152c6f8d	true	id.token.claim
319dcd57-5f83-48e1-9850-a47b152c6f8d	true	access.token.claim
319dcd57-5f83-48e1-9850-a47b152c6f8d	preferred_username	claim.name
319dcd57-5f83-48e1-9850-a47b152c6f8d	String	jsonType.label
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	true	introspection.token.claim
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	true	userinfo.token.claim
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	lastName	user.attribute
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	true	id.token.claim
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	true	access.token.claim
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	family_name	claim.name
5e97c6ce-36fc-410e-8c78-05f3c1bcaa01	String	jsonType.label
9501e7c4-a147-4829-b21c-0213645ce563	true	introspection.token.claim
9501e7c4-a147-4829-b21c-0213645ce563	true	userinfo.token.claim
9501e7c4-a147-4829-b21c-0213645ce563	birthdate	user.attribute
9501e7c4-a147-4829-b21c-0213645ce563	true	id.token.claim
9501e7c4-a147-4829-b21c-0213645ce563	true	access.token.claim
9501e7c4-a147-4829-b21c-0213645ce563	birthdate	claim.name
9501e7c4-a147-4829-b21c-0213645ce563	String	jsonType.label
99c65d6b-9e2b-42e5-afc5-228d67f19669	true	introspection.token.claim
99c65d6b-9e2b-42e5-afc5-228d67f19669	true	userinfo.token.claim
99c65d6b-9e2b-42e5-afc5-228d67f19669	locale	user.attribute
99c65d6b-9e2b-42e5-afc5-228d67f19669	true	id.token.claim
99c65d6b-9e2b-42e5-afc5-228d67f19669	true	access.token.claim
99c65d6b-9e2b-42e5-afc5-228d67f19669	locale	claim.name
99c65d6b-9e2b-42e5-afc5-228d67f19669	String	jsonType.label
9d88c445-5587-4a04-a08b-28651cc7dfd5	true	introspection.token.claim
9d88c445-5587-4a04-a08b-28651cc7dfd5	true	userinfo.token.claim
9d88c445-5587-4a04-a08b-28651cc7dfd5	zoneinfo	user.attribute
9d88c445-5587-4a04-a08b-28651cc7dfd5	true	id.token.claim
9d88c445-5587-4a04-a08b-28651cc7dfd5	true	access.token.claim
9d88c445-5587-4a04-a08b-28651cc7dfd5	zoneinfo	claim.name
9d88c445-5587-4a04-a08b-28651cc7dfd5	String	jsonType.label
b550c0fb-6b50-47d9-90d7-1fd75f090b6e	true	introspection.token.claim
b550c0fb-6b50-47d9-90d7-1fd75f090b6e	true	userinfo.token.claim
b550c0fb-6b50-47d9-90d7-1fd75f090b6e	true	id.token.claim
b550c0fb-6b50-47d9-90d7-1fd75f090b6e	true	access.token.claim
bfc74930-dd52-4489-907e-e0d0136a7079	true	introspection.token.claim
bfc74930-dd52-4489-907e-e0d0136a7079	true	userinfo.token.claim
bfc74930-dd52-4489-907e-e0d0136a7079	middleName	user.attribute
bfc74930-dd52-4489-907e-e0d0136a7079	true	id.token.claim
bfc74930-dd52-4489-907e-e0d0136a7079	true	access.token.claim
bfc74930-dd52-4489-907e-e0d0136a7079	middle_name	claim.name
bfc74930-dd52-4489-907e-e0d0136a7079	String	jsonType.label
c7416992-46b1-4112-8174-ec0cb2e83b65	true	introspection.token.claim
c7416992-46b1-4112-8174-ec0cb2e83b65	true	userinfo.token.claim
c7416992-46b1-4112-8174-ec0cb2e83b65	nickname	user.attribute
c7416992-46b1-4112-8174-ec0cb2e83b65	true	id.token.claim
c7416992-46b1-4112-8174-ec0cb2e83b65	true	access.token.claim
c7416992-46b1-4112-8174-ec0cb2e83b65	nickname	claim.name
c7416992-46b1-4112-8174-ec0cb2e83b65	String	jsonType.label
d35a3a4b-ede0-4be8-879c-cb109084d752	true	introspection.token.claim
d35a3a4b-ede0-4be8-879c-cb109084d752	true	userinfo.token.claim
d35a3a4b-ede0-4be8-879c-cb109084d752	updatedAt	user.attribute
d35a3a4b-ede0-4be8-879c-cb109084d752	true	id.token.claim
d35a3a4b-ede0-4be8-879c-cb109084d752	true	access.token.claim
d35a3a4b-ede0-4be8-879c-cb109084d752	updated_at	claim.name
d35a3a4b-ede0-4be8-879c-cb109084d752	long	jsonType.label
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	true	introspection.token.claim
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	true	userinfo.token.claim
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	profile	user.attribute
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	true	id.token.claim
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	true	access.token.claim
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	profile	claim.name
f557f717-26fd-401f-8a5f-3cc1fe9c4af1	String	jsonType.label
133dbff0-1b60-4fec-a735-088586ada99f	true	introspection.token.claim
133dbff0-1b60-4fec-a735-088586ada99f	true	userinfo.token.claim
133dbff0-1b60-4fec-a735-088586ada99f	emailVerified	user.attribute
133dbff0-1b60-4fec-a735-088586ada99f	true	id.token.claim
133dbff0-1b60-4fec-a735-088586ada99f	true	access.token.claim
133dbff0-1b60-4fec-a735-088586ada99f	email_verified	claim.name
133dbff0-1b60-4fec-a735-088586ada99f	boolean	jsonType.label
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	true	introspection.token.claim
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	true	userinfo.token.claim
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	email	user.attribute
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	true	id.token.claim
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	true	access.token.claim
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	email	claim.name
5e6c5655-2e3b-4071-87bb-3e035fa6fd7c	String	jsonType.label
e8825953-7fc7-46db-b1e5-33a58b51a739	formatted	user.attribute.formatted
e8825953-7fc7-46db-b1e5-33a58b51a739	country	user.attribute.country
e8825953-7fc7-46db-b1e5-33a58b51a739	true	introspection.token.claim
e8825953-7fc7-46db-b1e5-33a58b51a739	postal_code	user.attribute.postal_code
e8825953-7fc7-46db-b1e5-33a58b51a739	true	userinfo.token.claim
e8825953-7fc7-46db-b1e5-33a58b51a739	street	user.attribute.street
e8825953-7fc7-46db-b1e5-33a58b51a739	true	id.token.claim
e8825953-7fc7-46db-b1e5-33a58b51a739	region	user.attribute.region
e8825953-7fc7-46db-b1e5-33a58b51a739	true	access.token.claim
e8825953-7fc7-46db-b1e5-33a58b51a739	locality	user.attribute.locality
12046879-d98c-4608-8197-24f16a997b68	true	introspection.token.claim
12046879-d98c-4608-8197-24f16a997b68	true	userinfo.token.claim
12046879-d98c-4608-8197-24f16a997b68	phoneNumber	user.attribute
12046879-d98c-4608-8197-24f16a997b68	true	id.token.claim
12046879-d98c-4608-8197-24f16a997b68	true	access.token.claim
12046879-d98c-4608-8197-24f16a997b68	phone_number	claim.name
12046879-d98c-4608-8197-24f16a997b68	String	jsonType.label
ac209dda-012a-4fdd-b00b-10c4c305f95c	true	introspection.token.claim
ac209dda-012a-4fdd-b00b-10c4c305f95c	true	userinfo.token.claim
ac209dda-012a-4fdd-b00b-10c4c305f95c	phoneNumberVerified	user.attribute
ac209dda-012a-4fdd-b00b-10c4c305f95c	true	id.token.claim
ac209dda-012a-4fdd-b00b-10c4c305f95c	true	access.token.claim
ac209dda-012a-4fdd-b00b-10c4c305f95c	phone_number_verified	claim.name
ac209dda-012a-4fdd-b00b-10c4c305f95c	boolean	jsonType.label
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	true	introspection.token.claim
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	true	multivalued
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	foo	user.attribute
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	true	access.token.claim
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	resource_access.${client_id}.roles	claim.name
1856202a-7cf5-45af-ae5d-e65fdd85c4bd	String	jsonType.label
2409ee90-a6a9-474a-b84d-72f84c52846e	true	introspection.token.claim
2409ee90-a6a9-474a-b84d-72f84c52846e	true	multivalued
2409ee90-a6a9-474a-b84d-72f84c52846e	foo	user.attribute
2409ee90-a6a9-474a-b84d-72f84c52846e	true	access.token.claim
2409ee90-a6a9-474a-b84d-72f84c52846e	realm_access.roles	claim.name
2409ee90-a6a9-474a-b84d-72f84c52846e	String	jsonType.label
288b0cfd-bf11-41b9-9cf6-fb88145bc016	true	introspection.token.claim
288b0cfd-bf11-41b9-9cf6-fb88145bc016	true	access.token.claim
7b7b1108-eec1-4571-adb2-d7dfef52bd1f	true	introspection.token.claim
7b7b1108-eec1-4571-adb2-d7dfef52bd1f	true	access.token.claim
a9341755-d193-4ff1-a9b5-493814359756	true	introspection.token.claim
a9341755-d193-4ff1-a9b5-493814359756	true	userinfo.token.claim
a9341755-d193-4ff1-a9b5-493814359756	username	user.attribute
a9341755-d193-4ff1-a9b5-493814359756	true	id.token.claim
a9341755-d193-4ff1-a9b5-493814359756	true	access.token.claim
a9341755-d193-4ff1-a9b5-493814359756	upn	claim.name
a9341755-d193-4ff1-a9b5-493814359756	String	jsonType.label
cae19080-1884-4d38-8c4e-082a4f80e6d1	true	introspection.token.claim
cae19080-1884-4d38-8c4e-082a4f80e6d1	true	multivalued
cae19080-1884-4d38-8c4e-082a4f80e6d1	foo	user.attribute
cae19080-1884-4d38-8c4e-082a4f80e6d1	true	id.token.claim
cae19080-1884-4d38-8c4e-082a4f80e6d1	true	access.token.claim
cae19080-1884-4d38-8c4e-082a4f80e6d1	groups	claim.name
cae19080-1884-4d38-8c4e-082a4f80e6d1	String	jsonType.label
e73dfa2d-0dca-44e9-b370-d77bed38bf3a	true	introspection.token.claim
e73dfa2d-0dca-44e9-b370-d77bed38bf3a	true	id.token.claim
e73dfa2d-0dca-44e9-b370-d77bed38bf3a	true	access.token.claim
1db15c30-cadf-4515-9e78-5cc9344ede52	true	introspection.token.claim
1db15c30-cadf-4515-9e78-5cc9344ede52	true	access.token.claim
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	AUTH_TIME	user.session.note
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	true	introspection.token.claim
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	true	id.token.claim
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	true	access.token.claim
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	auth_time	claim.name
9afa5bf1-bfd4-4ce1-ae73-98dd86ae5b51	long	jsonType.label
1d6e2494-3ad7-48a9-8a03-170629fff4d2	true	introspection.token.claim
1d6e2494-3ad7-48a9-8a03-170629fff4d2	true	multivalued
1d6e2494-3ad7-48a9-8a03-170629fff4d2	true	id.token.claim
1d6e2494-3ad7-48a9-8a03-170629fff4d2	true	access.token.claim
1d6e2494-3ad7-48a9-8a03-170629fff4d2	organization	claim.name
1d6e2494-3ad7-48a9-8a03-170629fff4d2	String	jsonType.label
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	true	introspection.token.claim
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	true	userinfo.token.claim
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	locale	user.attribute
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	true	id.token.claim
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	true	access.token.claim
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	locale	claim.name
fb10ddf7-00bc-4bf5-b63f-bdd91e050915	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
03f0b788-c519-457c-9b1d-cc8412c32a1a	60	300	300	\N	\N	\N	t	f	0	\N	applier	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	e33b52c6-138d-4f57-b2fe-dbdbdb639a86	1800	f	\N	t	f	f	f	0	1	30	6	HmacSHA1	totp	7b543bc7-792f-4c75-87f1-06422cca581b	4f85b939-df9f-4bb2-8075-fcbbbe50a1d5	e308a996-9532-4425-8356-77c767bbc0c7	ebdbcf89-7984-4f51-9279-a018f5e6fd81	8041a3a2-d14f-4181-ad6f-a19683a85a75	2592000	f	900	t	f	b808dc26-b571-42de-ac7b-72b0c630427e	0	f	0	0	f2c1f439-4b26-44a4-8407-fb2f4f9b7b79
68d4a947-cff1-493f-8942-868a60f3a7a4	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	8fb0377b-b032-4b45-837b-190c9c97c494	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	06266cab-15a5-4807-ad2d-801fe6ee875e	cb79672d-8778-4fe4-8da8-34fad42332c3	4d776a13-6822-4604-98cd-e848385b8add	37d54ee1-5f22-4064-8ca7-90c5699ce205	ed28a595-5a40-436c-933d-91f8f2b8a64f	2592000	f	900	t	f	0cb50458-fb21-4fce-8796-1ca39d56f086	0	f	0	0	d829e28b-69ed-47d0-a32b-9409b3f017b0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	68d4a947-cff1-493f-8942-868a60f3a7a4	
_browser_header.xContentTypeOptions	68d4a947-cff1-493f-8942-868a60f3a7a4	nosniff
_browser_header.referrerPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	no-referrer
_browser_header.xRobotsTag	68d4a947-cff1-493f-8942-868a60f3a7a4	none
_browser_header.xFrameOptions	68d4a947-cff1-493f-8942-868a60f3a7a4	SAMEORIGIN
_browser_header.contentSecurityPolicy	68d4a947-cff1-493f-8942-868a60f3a7a4	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	68d4a947-cff1-493f-8942-868a60f3a7a4	1; mode=block
_browser_header.strictTransportSecurity	68d4a947-cff1-493f-8942-868a60f3a7a4	max-age=31536000; includeSubDomains
bruteForceProtected	68d4a947-cff1-493f-8942-868a60f3a7a4	false
permanentLockout	68d4a947-cff1-493f-8942-868a60f3a7a4	false
maxTemporaryLockouts	68d4a947-cff1-493f-8942-868a60f3a7a4	0
bruteForceStrategy	68d4a947-cff1-493f-8942-868a60f3a7a4	MULTIPLE
maxFailureWaitSeconds	68d4a947-cff1-493f-8942-868a60f3a7a4	900
minimumQuickLoginWaitSeconds	68d4a947-cff1-493f-8942-868a60f3a7a4	60
waitIncrementSeconds	68d4a947-cff1-493f-8942-868a60f3a7a4	60
quickLoginCheckMilliSeconds	68d4a947-cff1-493f-8942-868a60f3a7a4	1000
maxDeltaTimeSeconds	68d4a947-cff1-493f-8942-868a60f3a7a4	43200
failureFactor	68d4a947-cff1-493f-8942-868a60f3a7a4	30
realmReusableOtpCode	68d4a947-cff1-493f-8942-868a60f3a7a4	false
firstBrokerLoginFlowId	68d4a947-cff1-493f-8942-868a60f3a7a4	8baaeddb-fad8-49d3-99dc-57a2cb9849c9
displayName	68d4a947-cff1-493f-8942-868a60f3a7a4	Keycloak
displayNameHtml	68d4a947-cff1-493f-8942-868a60f3a7a4	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	68d4a947-cff1-493f-8942-868a60f3a7a4	RS256
offlineSessionMaxLifespanEnabled	68d4a947-cff1-493f-8942-868a60f3a7a4	false
offlineSessionMaxLifespan	68d4a947-cff1-493f-8942-868a60f3a7a4	5184000
bruteForceProtected	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
permanentLockout	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
maxTemporaryLockouts	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
bruteForceStrategy	03f0b788-c519-457c-9b1d-cc8412c32a1a	MULTIPLE
maxFailureWaitSeconds	03f0b788-c519-457c-9b1d-cc8412c32a1a	900
minimumQuickLoginWaitSeconds	03f0b788-c519-457c-9b1d-cc8412c32a1a	60
waitIncrementSeconds	03f0b788-c519-457c-9b1d-cc8412c32a1a	60
quickLoginCheckMilliSeconds	03f0b788-c519-457c-9b1d-cc8412c32a1a	1000
maxDeltaTimeSeconds	03f0b788-c519-457c-9b1d-cc8412c32a1a	43200
failureFactor	03f0b788-c519-457c-9b1d-cc8412c32a1a	30
realmReusableOtpCode	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
defaultSignatureAlgorithm	03f0b788-c519-457c-9b1d-cc8412c32a1a	RS256
offlineSessionMaxLifespanEnabled	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
offlineSessionMaxLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	5184000
actionTokenGeneratedByAdminLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	43200
actionTokenGeneratedByUserLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	300
oauth2DeviceCodeLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	600
oauth2DevicePollingInterval	03f0b788-c519-457c-9b1d-cc8412c32a1a	5
webAuthnPolicyRpEntityName	03f0b788-c519-457c-9b1d-cc8412c32a1a	keycloak
webAuthnPolicySignatureAlgorithms	03f0b788-c519-457c-9b1d-cc8412c32a1a	ES256,RS256
webAuthnPolicyRpId	03f0b788-c519-457c-9b1d-cc8412c32a1a	
webAuthnPolicyAttestationConveyancePreference	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyAuthenticatorAttachment	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyRequireResidentKey	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyUserVerificationRequirement	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyCreateTimeout	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
webAuthnPolicyAvoidSameAuthenticatorRegister	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
webAuthnPolicyRpEntityNamePasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	ES256,RS256
webAuthnPolicyRpIdPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	
webAuthnPolicyAttestationConveyancePreferencePasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyRequireResidentKeyPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	not specified
webAuthnPolicyCreateTimeoutPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
cibaBackchannelTokenDeliveryMode	03f0b788-c519-457c-9b1d-cc8412c32a1a	poll
cibaExpiresIn	03f0b788-c519-457c-9b1d-cc8412c32a1a	120
cibaInterval	03f0b788-c519-457c-9b1d-cc8412c32a1a	5
cibaAuthRequestedUserHint	03f0b788-c519-457c-9b1d-cc8412c32a1a	login_hint
parRequestUriLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	60
firstBrokerLoginFlowId	03f0b788-c519-457c-9b1d-cc8412c32a1a	f253863e-b9d7-4998-b687-d40e326145b5
organizationsEnabled	03f0b788-c519-457c-9b1d-cc8412c32a1a	false
clientSessionIdleTimeout	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
clientSessionMaxLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
clientOfflineSessionIdleTimeout	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
clientOfflineSessionMaxLifespan	03f0b788-c519-457c-9b1d-cc8412c32a1a	0
client-policies.profiles	03f0b788-c519-457c-9b1d-cc8412c32a1a	{"profiles":[]}
client-policies.policies	03f0b788-c519-457c-9b1d-cc8412c32a1a	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	03f0b788-c519-457c-9b1d-cc8412c32a1a	
_browser_header.xContentTypeOptions	03f0b788-c519-457c-9b1d-cc8412c32a1a	nosniff
_browser_header.referrerPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	no-referrer
_browser_header.xRobotsTag	03f0b788-c519-457c-9b1d-cc8412c32a1a	none
_browser_header.xFrameOptions	03f0b788-c519-457c-9b1d-cc8412c32a1a	SAMEORIGIN
_browser_header.contentSecurityPolicy	03f0b788-c519-457c-9b1d-cc8412c32a1a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	03f0b788-c519-457c-9b1d-cc8412c32a1a	1; mode=block
_browser_header.strictTransportSecurity	03f0b788-c519-457c-9b1d-cc8412c32a1a	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
68d4a947-cff1-493f-8942-868a60f3a7a4	jboss-logging
03f0b788-c519-457c-9b1d-cc8412c32a1a	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	68d4a947-cff1-493f-8942-868a60f3a7a4
password	password	t	t	03f0b788-c519-457c-9b1d-cc8412c32a1a
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
0f42204d-a34b-47a3-909a-f719aab1800f	/realms/master/account/*
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	/realms/master/account/*
5bbfe09f-079f-40e6-aa17-33fc2e201325	/admin/master/console/*
2173459a-3937-4744-a323-e9f6ec19f1bc	/realms/applier/account/*
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	/realms/applier/account/*
972a6183-c205-4fcf-8ac3-649e22dd4a40	/admin/applier/console/*
5098521b-57a9-4016-ba7f-4d03d33341aa	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
5a4fe0f4-e73a-40e9-a24f-c8626f48a494	VERIFY_EMAIL	Verify Email	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	VERIFY_EMAIL	50
7f3cad81-27eb-41cc-a4b4-06f4f5b0ee66	UPDATE_PROFILE	Update Profile	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	UPDATE_PROFILE	40
e730c4ae-d63b-4f86-b498-104c743ca55e	CONFIGURE_TOTP	Configure OTP	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	CONFIGURE_TOTP	10
5b1d9471-6ac1-4089-9b93-c5b9c7e607d9	UPDATE_PASSWORD	Update Password	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	UPDATE_PASSWORD	30
491ea89e-9e46-44b6-bab4-d613365f9cdd	TERMS_AND_CONDITIONS	Terms and Conditions	68d4a947-cff1-493f-8942-868a60f3a7a4	f	f	TERMS_AND_CONDITIONS	20
5dd6681b-574c-4c54-88ec-a69aeecdb349	delete_account	Delete Account	68d4a947-cff1-493f-8942-868a60f3a7a4	f	f	delete_account	60
bb54f4b4-06fe-4b15-92ce-19ee34a9322a	delete_credential	Delete Credential	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	delete_credential	100
5b14acda-cc41-47af-a1c7-35a74dec2f45	update_user_locale	Update User Locale	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	update_user_locale	1000
b22e2135-018c-485f-bd34-4dd693949f5b	webauthn-register	Webauthn Register	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	webauthn-register	70
2674b0b9-18de-4993-ab38-a3bce8952fb7	webauthn-register-passwordless	Webauthn Register Passwordless	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	webauthn-register-passwordless	80
ab0f4412-da29-4111-ae46-5fbfd06aa0e4	VERIFY_PROFILE	Verify Profile	68d4a947-cff1-493f-8942-868a60f3a7a4	t	f	VERIFY_PROFILE	90
56d4db4c-425b-4465-a8f5-a697930c6694	TERMS_AND_CONDITIONS	Terms and Conditions	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	TERMS_AND_CONDITIONS	20
737b0fac-b806-4787-b719-6f341649206c	delete_account	Delete Account	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	delete_account	60
a45d4aef-2968-452c-9021-1daf906a2ad6	CONFIGURE_TOTP	Configure OTP	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	CONFIGURE_TOTP	10
5076d585-dc3e-4e0c-8805-ac16b37120a4	UPDATE_PASSWORD	Update Password	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	UPDATE_PASSWORD	30
e1354c65-4fff-4764-8942-709ae344fbe6	UPDATE_PROFILE	Update Profile	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	UPDATE_PROFILE	40
a6cc714c-7240-4c34-8545-d8615e024999	VERIFY_EMAIL	Verify Email	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	VERIFY_EMAIL	50
f1a2aa38-7d76-4d3d-b3d5-db69f38ade41	webauthn-register	Webauthn Register	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	webauthn-register	70
b24ebebd-ad0b-4147-9298-c1e6ab4efe16	webauthn-register-passwordless	Webauthn Register Passwordless	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	webauthn-register-passwordless	80
641429c9-49f9-421d-85f8-eb4b34f8e679	VERIFY_PROFILE	Verify Profile	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	VERIFY_PROFILE	90
3c9d3177-82a0-434a-9b62-085a719728fb	delete_credential	Delete Credential	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	delete_credential	100
40edb48a-3672-4137-b597-795aca8e8eb8	update_user_locale	Update User Locale	03f0b788-c519-457c-9b1d-cc8412c32a1a	f	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	42473e7f-b9f3-402d-af1f-c0c8751dd6c9
8e23a6ec-a04d-4565-bef0-fa70ba0f698f	f9cc697b-8494-4bd5-a5aa-e2fe7b1d7e4d
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	e95a2bac-437b-4275-8af2-f710b56f2ae9
dacefb67-ba86-4048-bcdc-d64b69ba2cf5	be6c1d9e-0491-4d89-baac-e1cf67a18fd5
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	710fbe72-64b9-4b25-8216-7163b3989894	2cb576ba-8638-4628-bb7b-ea1c6cc89b6c	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
710fbe72-64b9-4b25-8216-7163b3989894	\N	3f214aa0-7ba2-419c-8db9-b6c8b297a5c4	f	t	\N	\N	\N	68d4a947-cff1-493f-8942-868a60f3a7a4	admin	1791868979617	\N	0
131d6c7c-b654-4088-ac8b-586972c2bc6c	we00007@mix.wvu.edu	we00007@mix.wvu.edu	f	t	\N	\N	\N	03f0b788-c519-457c-9b1d-cc8412c32a1a	we00007@mix.wvu.edu	1792006076542	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
d829e28b-69ed-47d0-a32b-9409b3f017b0	710fbe72-64b9-4b25-8216-7163b3989894
90be2d91-ef25-4156-ada8-056a2941c5e5	710fbe72-64b9-4b25-8216-7163b3989894
f2c1f439-4b26-44a4-8407-fb2f4f9b7b79	131d6c7c-b654-4088-ac8b-586972c2bc6c
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres_keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
5bbfe09f-079f-40e6-aa17-33fc2e201325	+
972a6183-c205-4fcf-8ac3-649e22dd4a40	+
5098521b-57a9-4016-ba7f-4d03d33341aa	*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres_keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres_keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict Sa92Krx22JUjk9xBLtFRIH8W0PuAtIwmZof4WkRCZeNJeNziICj4iBK2NHHYWov

