---@diagnostic disable: undefined-global
function _config()
  return { name = "Ping Pong USAGI",
          game_id = "com.usagiengine.PingPongUsagi",
          game_width = 240,
          game_height = 160,
        pixel_perfect = true }
end
--local vars

local player_y = 70
local enemy_y = 70
local ball_x = 120
local ball_y = 60
local ball_dy = 2.0 --speed to move vertically
local ball_dx = 2.0 --speed to move horii

local pad_w = 8
local pad_h = 35

function _init()
end

function _update(dt)
-- Player Movement: Moves only while key is held
  if input.held(input.UP) and player_y > 0 then
    player_y = player_y - 2
  end
  if input.held(input.DOWN) and player_y < (usagi.GAME_H - pad_h) then
    player_y = player_y + 2
  end

  
  ball_x = ball_x + ball_dx
  ball_y = ball_y + ball_dy

  
  if ball_y <= 0 or ball_y >= (usagi.GAME_H - 5) then
    ball_dy = -ball_dy
  end

  if ball_x < 20 and ball_y > player_y and ball_y < (player_y + pad_h) then
    ball_dx = math.abs(ball_dx) 
    ball_x = 20                 
    effect.screen_shake(0.1, 1.2) 
  end

  if ball_x > (usagi.GAME_W - 28) and ball_y > enemy_y and ball_y < (enemy_y + pad_h) then
    ball_dx = -math.abs(ball_dx) 
    ball_x = usagi.GAME_W - 28   
    effect.screen_shake(0.1, 1.2)  
  end

  if ball_x < 0 or ball_x > usagi.GAME_W then
    ball_x = usagi.GAME_W / 2
    ball_y = usagi.GAME_H / 2
    ball_dx = -ball_dx 
    effect.flash(0.20, gfx.COLOR_RED) 
  end

  
  if enemy_y + (pad_h / 2) < ball_y then
    enemy_y = enemy_y + 1
  elseif enemy_y + (pad_h / 2) > ball_y then
    enemy_y = enemy_y - 1
  end
end


function _draw(dt)
  gfx.clear(gfx.COLOR_LIGHT_GRAY)

 
--this is  de ball
  gfx.circ_fill(ball_x, ball_y, 5, gfx.COLOR_BLACK) --black

--this is de paddle
gfx.rect_fill(12, player_y, pad_w, pad_h, gfx.COLOR_BLACK)
  
--enemy paddle
gfx.rect_fill(usagi.GAME_W - 20, enemy_y, pad_w, pad_h, gfx.COLOR_BLACK)


end
