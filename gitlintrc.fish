set -gx GITLINT_CONFIG ~/.config/gitlint/gitlint.ini
set -gx GITLINT_EXTRA_PATH ~/.config/gitlint/gitlint-rules/
set -gx GITLINT_REMOTE origin
set -gx GITLINT_TARGET_REF master
set -gx GITLINT_COMMIT_RANGE $GITLINT_REMOTE/$GITLINT_TARGET_REF...HEAD
set -gx GITLINT_EXTRA_ARGS ""
