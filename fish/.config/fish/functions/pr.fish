# Creates a draft pull request and opens it in the browser.
function pr --wraps hub\ pull-request
	hub pull-request -d -o $argv
end
