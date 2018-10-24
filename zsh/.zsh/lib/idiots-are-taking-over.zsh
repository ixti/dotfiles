IDIOTS_ARE_TAKING_OVER="\xe2\xa7\xb8"

# Replace slashes in given string with Unicode BIG+SOLIDUS.
#
# RATIONALE:
#
#   Some devops fail to do their job and instead of searching for workarounds
#   for Jenkins git plugin known issues forbid using slash in branch name. But
#   as git does not provide any sanity checks they do it (!) as part of CI which
#   makes absolutley no fucking sense as it does not solves anything.
#
# USAGE:
#
#   git checkout -b $(idiots_are_taking_over ixti/kiss-my-shiny-metal-ass)
function idiots_are_taking_over() {
  echo "$1" | sed "s/\//${IDIOTS_ARE_TAKING_OVER}/g"
}
