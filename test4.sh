status=0;

function error_and_die {
  echo -e "ERROR: ${1}" >&2;
  exit 1;
};

if [ "${status}" -eq 1 ]; then
    error_and_die "Terraform plan failed";
fi;

echo "hello"