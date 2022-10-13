" lightswitch.vim - automatically reflect OS appearance theme
" Maintainer: Josh Petrie <http://joshpetrie.net>
" Version:    0.0

if exists("g:loaded_lightswitch")
  finish
endif

let g:loaded_lightswitch = 1

if !exists("g:lightswitch_interval")
  let g:lightswitch_interval = 1000
endif

function LightswitchTryUpdate(is_light)
  let style = "light"
  if a:is_light == 0
    let style = "dark"
  endif

  if &background != style
    " Setting the background will reload the color scheme, so we only do it when neccessary.
    execute "set background=" . style
  endif
endfunction

function LightswitchJobCompleteNvim(job, data, event)
  call LightswitchTryUpdate(a:data)
endfunction

function LightswitchJobCompleteVim(job, status)
  call LightswitchTryUpdate(a:status)
endfunction

function LightswitchCheckAppearance(...)
  let command = ["defaults", "read", "-g", "AppleInterfaceStyle"]
  if has("nvim")
    call jobstart(command, {"on_exit": "LightswitchJobCompleteNvim"})
  else
    " In vim, we must hold a reference to the job object at least until the job completes, otherwise vim may destroy it.
    let s:job = job_start(command, {"exit_cb": "LightswitchJobCompleteVim"})
  endif
endfunction

if has("mac")
  call LightswitchCheckAppearance()
  if g:lightswitch_interval > 0
    let g:lightswitch_timer = timer_start(g:lightswitch_interval, "LightswitchCheckAppearance", {"repeat": -1})
  endif
endif
