#!/bin/bash

# Redirect stderr so everything ends up in the log file
exec 2>&1
exec ${CATALINA_HOME}/bin/catalina.sh run 2>&1
