--[[
Clock Rings by Linux Mint (2011) reEdited by despot77

This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/rings.lua
	lua_draw_hook_pre rings

Changelog:
+ v1.0 -- Original release (30.09.2009)
   v1.1p -- Jpope edit londonali1010 (05.10.2009)
*v 2011mint -- reEdit despot77 (18.02.2011)

(customized by larry)
]]

settings_table = {
--[[
	{
		-- Edit this table to customise your rings.
		-- You can create more rings simply by adding more elements to settings_table.
		-- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
		name='time',
		-- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
		arg='%I.%M',
		-- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
		max=12,
		-- "bg_colour" is the colour of the base ring.
		bg_colour=0xffffff,
		-- "bg_alpha" is the alpha value of the base ring.
		bg_alpha=0.1,
		-- "fg_colour" is the colour of the indicator part of the ring.
		fg_colour=0xFF6600,
		-- "fg_alpha" is the alpha value of the indicator part of the ring.
		fg_alpha=0.2,
		-- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
		x=100, y=150,
		-- "radius" is the radius of the ring.
		radius=50,
		-- "thickness" is the thickness of the ring, centred around the radius.
		thickness=5,
		-- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
		start_angle=0,
		-- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.
		end_angle=360
	},
]]
	-- cpu usage
	{
		name='cpu',
		arg='cpu0',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=115,
		thickness=10,
		start_angle=-90,
		end_angle=270,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC00,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='cpu',
		arg='cpu1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=105,
		thickness=6,
		start_angle=-89,
		end_angle=-1,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='cpu',
		arg='cpu2',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=105,
		thickness=6,
		start_angle=1,
		end_angle=89,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='cpu',
		arg='cpu3',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=105,
		thickness=6,
		start_angle=91,
		end_angle=179,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='cpu',
		arg='cpu4',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=105,
		thickness=6,
		start_angle=181,
		end_angle=269,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	-- cpu frequency
	{
		name='exec',
		--arg='echo \'scale=1;100*\'`cpufreq-info -c 0 -f`/`cpufreq-info -c 0 -l|awk \'{print $2}\'`|bc',
		arg='echo \'scale=1;100*\'`echo $(cpufreq-info -c 0 -f;cpufreq-info -c 0 -l)|tr "\\n" " "|awk \'{print "("$1"-"$2")/("$3"-"$2")"}\'`|bc',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=92,
		thickness=4,
		start_angle=-89,
		end_angle=-1,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='exec',
		--arg='echo \'scale=1;100*\'`cpufreq-info -c 1 -f`/`cpufreq-info -c 1 -l|awk \'{print $2}\'`|bc',
		arg='echo \'scale=1;100*\'`echo $(cpufreq-info -c 1 -f;cpufreq-info -c 1 -l)|tr "\\n" " "|awk \'{print "("$1"-"$2")/("$3"-"$2")"}\'`|bc',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=92,
		thickness=4,
		start_angle=1,
		end_angle=89,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='exec',
		--arg='echo \'scale=1;100*\'`cpufreq-info -c 2 -f`/`cpufreq-info -c 2 -l|awk \'{print $2}\'`|bc',
		arg='echo \'scale=1;100*\'`echo $(cpufreq-info -c 2 -f;cpufreq-info -c 2 -l)|tr "\\n" " "|awk \'{print "("$1"-"$2")/("$3"-"$2")"}\'`|bc',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=92,
		thickness=4,
		start_angle=91,
		end_angle=179,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='exec',
		--arg='echo \'scale=1;100*\'`cpufreq-info -c 3 -f`/`cpufreq-info -c 3 -l|awk \'{print $2}\'`|bc',
		arg='echo \'scale=1;100*\'`echo $(cpufreq-info -c 3 -f;cpufreq-info -c 3 -l)|tr "\\n" " "|awk \'{print "("$1"-"$2")/("$3"-"$2")"}\'`|bc',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=128, y=150,
		radius=92,
		thickness=4,
		start_angle=181,
		end_angle=269,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	-- cpu temperature
	{
		name='hwmon',
		arg='temp 2',
		max=120,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x006699,
		fg_alpha=0.8,
		x=128, y=150,
		radius=98,
		thickness=4,
		start_angle=-89,
		end_angle=89,
		change_colour_when_high=true,
		when_high={
			{
				threshold=82,
				bg_colour=0xff0000,
				fg_colour=0xFF0000,
				bg_alpha=0.3,
				fg_alpha=0.7
			},
			{
				threshold=60,
				bg_colour=0xffffff,
				fg_colour=0xFFEE00,
				bg_alpha=0.2,
				fg_alpha=0.8
			},
			{
				threshold=46,
				bg_colour=0xffffff,
				fg_colour=0x99CC00,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='hwmon',
		arg='temp 3',
		max=120,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x006699,
		fg_alpha=0.8,
		x=128, y=150,
		radius=98,
		thickness=4,
		start_angle=91,
		end_angle=269,
		change_colour_when_high=true,
		when_high={
			{
				threshold=82,
				bg_colour=0xff0000,
				fg_colour=0xFF0000,
				bg_alpha=0.3,
				fg_alpha=0.7
			},
			{
				threshold=60,
				bg_colour=0xffffff,
				fg_colour=0xFFEE00,
				bg_alpha=0.2,
				fg_alpha=0.8
			},
			{
				threshold=46,
				bg_colour=0xffffff,
				fg_colour=0x99CC00,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	-- memory usage
	{
		name='memperc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=378, y=150,
		radius=115,
		thickness=10,
		start_angle=-90,
		end_angle=180,
		change_colour_when_high=true,
		when_high={
			{
				threshold=80,
				bg_colour=0xff0000,
				fg_colour=0xFF0000,
				bg_alpha=0.3,
				fg_alpha=0.7
			},
			{
				threshold=200/3,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	-- swap usage
	{
		name='swapperc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=378, y=150,
		radius=117,
		thickness=5,
		start_angle=182,
		end_angle=268,
		change_colour_when_high=true,
		when_high={
			{
				threshold=75,
				bg_colour=0xff0000,
				fg_colour=0xFF0000,
				bg_alpha=0.3,
				fg_alpha=0.7
			},
			{
				threshold=200/3,
				bg_colour=0xffffff,
				fg_colour=0xFFCC33,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	-- available entropy ("for crypto freaks")
	{
		name='entropy_perc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=378, y=150,
		radius=112,
		thickness=3,
		start_angle=182,
		end_angle=268,
		change_colour_when_high=true,
		when_high={
			{
				threshold=200/3,
				bg_colour=0xffffff,
				fg_colour=0xFFCC00,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
	{
		name='entropy_perc',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=378, y=150,
		radius=106,
		thickness=5,
		start_angle=-90,
		end_angle=180,
		change_colour_when_high=true,
		when_high={
			{
				threshold=200/3,
				bg_colour=0xffffff,
				fg_colour=0xFFCC00,
				bg_alpha=0.2,
				fg_alpha=0.8
			}
		}
	},
--[[
	{
		name='battery_percent',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=378, y=150,
		radius=105,
		thickness=5,
		start_angle=-90,
		end_angle=180,
		change_colour_when_high=true,
		when_high={
			{
				threshold=200/3,
				bg_colour=0xff0000,
				fg_colour=0xFF6600,
				bg_alpha=0.3,
				fg_alpha=0.7
			}
		}
	},
]]
	-- filesystem usage
	{
		name='fs_used_perc',
		arg='/',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=45, y=400,
		radius=30,
		thickness=5,
		start_angle=-90,
		end_angle=180,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xff0000,
				fg_colour=0xFF6600,
				bg_alpha=0.3,
				fg_alpha=0.7
			}
		}
	},
	{
		name='fs_used_perc',
		arg='/home',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=115, y=400,
		radius=30,
		thickness=5,
		start_angle=-90,
		end_angle=180,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xff0000,
				fg_colour=0xFF6600,
				bg_alpha=0.3,
				fg_alpha=0.7
			}
		}
	},
	{
		name='fs_used_perc',
		arg='/data1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0x339900,
		fg_alpha=0.8,
		x=185, y=400,
		radius=30,
		thickness=5,
		start_angle=-90,
		end_angle=180,
		change_colour_when_high=true,
		when_high={
			{
				threshold=85,
				bg_colour=0xff0000,
				fg_colour=0xFF6600,
				bg_alpha=0.3,
				fg_alpha=0.7
			}
		}
	}
}

-- Use these settings to define the origin and extent of your clock.

clock_r=65

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=100
clock_y=150

show_seconds=true

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height

	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	if pt['change_colour_when_high'] then
		for i in pairs(pt['when_high']) do
			if t*pt['max']>=pt['when_high'][i]['threshold'] then
				bgc=pt['when_high'][i]['bg_colour']
				fgc=pt['when_high'][i]['fg_colour']
				bga=pt['when_high'][i]['bg_alpha']
				fga=pt['when_high'][i]['fg_alpha']
				break;
			end
		end
	end

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)

	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
end

--[[
function draw_clock_hands(cr,xc,yc)
	local secs,mins,hours,secs_arc,mins_arc,hours_arc
	local xh,yh,xm,ym,xs,ys

	secs=os.date("%S")
	mins=os.date("%M")
	hours=os.date("%I")

	secs_arc=(2*math.pi/60)*secs
	mins_arc=(2*math.pi/60)*mins+secs_arc/60
	hours_arc=(2*math.pi/12)*hours+mins_arc/12

	-- Draw hour hand

	xh=xc+0.7*clock_r*math.sin(hours_arc)
	yh=yc-0.7*clock_r*math.cos(hours_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xh,yh)

	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr,5)
	cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
	cairo_stroke(cr)

	-- Draw minute hand

	xm=xc+clock_r*math.sin(mins_arc)
	ym=yc-clock_r*math.cos(mins_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xm,ym)

	cairo_set_line_width(cr,3)
	cairo_stroke(cr)

	-- Draw seconds hand

	if show_seconds then
		xs=xc+clock_r*math.sin(secs_arc)
		ys=yc-clock_r*math.cos(secs_arc)
		cairo_move_to(cr,xc,yc)
		cairo_line_to(cr,xs,ys)

		cairo_set_line_width(cr,1)
		cairo_stroke(cr)
	end
end
]]

--function conky_clock_rings()
function conky_rings()
	local function setup_rings(cr,pt)
		local str=''
		local value=0

		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)

		value=tonumber(str)
		pct=value/pt['max']

		draw_ring(cr,pct,pt)
	end

	-- Check that Conky has been running for at least 5s

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

	local cr=cairo_create(cs)

	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)

	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end

	--draw_clock_hands(cr,clock_x,clock_y)
end
