#!/bin/sh
set -e

PHP_FULL_VERSION=$(php -r 'echo phpversion();')

if [ -z "$1" ]; then
  DIR_TO_SCAN="."
else
  DIR_TO_SCAN="$1"
fi

if [ -z "$2" ]; then
  EXTENSIONS="php,module,inc,install,test,profile,theme,css,info,txt,md,yml"
else
  EXTENSIONS="$2"
fi

if [ -z "$3" ]; then
  STANDARD="PEAR"
else
  STANDARD="$3"
fi

if [ -z "$4" ]; then
  INSTALLED_PATHS="vendor/drupal/coder/coder_sniffer"
else
  INSTALLED_PATHS="$4"
fi

echo "## Running PHPCS on ${DIR_TO_SCAN}"
echo "PHP Version : ${PHP_FULL_VERSION}"

if [ ! -d "${DIR_TO_SCAN}" ] && [ ! -f "${DIR_TO_SCAN}" ]; then
  php -d memory_limit=-1 /phpcs -pv
  echo "\nInvalid directory or file: ${DIR_TO_SCAN}"
  echo "\n\n"

  exit 2
fi

echo "php -d memory_limit=-1 /phpcs ${DIR_TO_SCAN} --standard=${STANDARD} --extensions=${EXTENSIONS} -pv"

php -d memory_limit=-1 /phpcs --config-set installed_paths ${INSTALLED_PATHS}

php -d memory_limit=-1 /phpcs ${DIR_TO_SCAN} --standard=${STANDARD} --extensions=${EXTENSIONS} -pv
