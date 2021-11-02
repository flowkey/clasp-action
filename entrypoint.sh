#!/bin/sh -l

CLASP=$(cat <<-END
    {
        "scriptId": "$2"
    }
END
)

if [ -n "$3" ]; then
  if [ -e "$3" ]; then
    cd "$3"
  else
    echo "rootDir is invalid."
    exit 1
  fi
fi

echo $1 > .clasprc.json
echo $CLASP > .clasp.json

if [ "$4" = "push" ]; then
  clasp push -f
elif [ "$4" = "deploy" ]; then
  if [ -n "$5" ]; then
    clasp push -f

    if [ -n "${6}" ]; then
      clasp deploy --description $5 -i ${6}
    else
      clasp deploy --description $5
    fi
  else
    clasp push -f

    if [ -n "${6}" ]; then
      clasp deploy -i ${6}
    else
      clasp deploy
    fi
  fi
else
  echo "command is invalid."
  exit 1
fi
