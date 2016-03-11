#!/bin/bash

if [ "$XDEBUG_ENABLED" = true ]; then
    echo "XDebug enabled.."
    cat /opt/etc/xdebug.ini >> /usr/local/etc/php/conf.d/xdebug.ini
fi


if [ "$NEWRELIC_ENABLED" = true ]; then
    echo "Enabling New Relic.."
    cat /opt/etc/newrelic.ini >> /usr/local/etc/php/conf.d/newrelic.ini
    sed -i -- 's/REPLACE_WITH_REAL_KEY/'${NEWRELIC_KEY}'/g' /usr/local/etc/php/conf.d/newrelic.ini
    sed -i -- 's/REPLACE APPLICATION NAME/'${NEWRELIC_APPNAME}'/g' /usr/local/etc/php/conf.d/newrelic.ini
    sed -i -- 's/;newrelic.enabled/newrelic.enabled/g' /usr/local/etc/php/conf.d/newrelic.ini
fi

exec php-fpm
