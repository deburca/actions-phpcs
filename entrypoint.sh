#!/bin/sh
set -e

PHP_FULL_VERSION=$(php -r 'echo phpversion();')

if [ -z "$1" ]; then
  DIR_TO_SCAN="."
else
  DIR_TO_SCAN="$1"
fi

if [ -z "$2" ]; then
  SCRIPT="php -d memory_limit=-1 /phpcs"
else
  SCRIPT="composer run-script $2"
fi

echo "## Running PHPCS on ${DIR_TO_SCAN}"
echo "PHP Version : ${PHP_FULL_VERSION}"

if [ ! -d "${DIR_TO_SCAN}" ] && [ ! -f "${DIR_TO_SCAN}" ]; then
  php -d memory_limit=-1 $BIN -pv
  echo "\nInvalid directory or file: ${DIR_TO_SCAN}"
  echo "\n\n"

  exit 2
fi

echo "${SCRIPT} ${DIR_TO_SCAN} -pv"

${SCRIPT} ${DIR_TO_SCAN} -pv
