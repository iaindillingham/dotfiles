function install-devtools --description 'Install development tools'
    command uv pip install ipython pdbpp
end

complete --command install-devtools
