#!/usr/bin/env bash
# ==============================================================================
# Community Home Assistant Add-ons: Bashio
# Bashio is an bash function library for use with Home Assistant add-ons.
#
# It contains a set of commonly used operations and can be used
# to be included in add-on scripts to reduce code duplication across add-ons.
# ==============================================================================

# ------------------------------------------------------------------------------
# Publish a new configuration object for discovery.
#
# Arguments:
#   $1 Service name
#   $2 Configuration object (JSON)
# ------------------------------------------------------------------------------
function bashio::discovery() {
    local service=${1}
    local config=${2}
    local payload

    bashio::log.trace "${FUNCNAME[0]}:" "$@"

    payload=$(\
        bashio::var.json \
            service "${service}" \
            config "^${config}" \
    )

    bashio::api.hassio "POST" "/discovery" "${payload}" ".uuid"
    bashio::cache.flush_all
}

# ------------------------------------------------------------------------------
# Deletes configuration object for this discovery.
#
# Arguments:
#   $1 Discovery UUID
# ------------------------------------------------------------------------------
function bashio::discovery.delete() {
    local uuid=${1}

    bashio::log.trace "${FUNCNAME[0]}:" "$@"
    bashio::api.hassio "DELETE" "/discovery/${uuid}"
    bashio::cache.flush_all
}
