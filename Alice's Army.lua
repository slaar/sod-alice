--army combat controller
--cards
--1 Alchemist(Foil)	1-5	5	
--2 Guard(Foil)		1-2	6	
--3 Halberder(Foil)	4	4	
--4 Mad Bomber(Foil)	2	1	Special Attack: Deal 1 damage to all units (friendly and enemy)	 
--5 Ninja(Foil)		8	1	
--6 Nurse(Foil)		1	3	End of Round: Heal all adjacent friendly units by 1 HP.	 
--7 Page(Foil)		1	4	Special: The friendly card in front of her gets +1 Attack power for base attacks.	 
--8 Shieldmaiden(Foil)1	4	Special: Any damage to the friendly card in front of her is reduced by 1, minimum of 1.	 
--9 Spearsman(Foil)	3	5	
--10 Swordsman(Foil)	2-4	5	
--11 Wallman(Foil)		1	8	
--12 Bowman(Foil)		1	4	Special: Deal 3 damage to the enemy in Rank 2	 
--13 Cleric(Foil)		1	1	End of Round: Heal rearmost wounded friendly unit by 1-2.	 
--14 Coward(Foil)		2	3	Special: Always runs behind cards placed after him.	 
--15 Hammerman(Foil)	0	5	Special Attack: Deals half of the opponent's max HP (round up).	 
--16 Horseman(Foil)	2	5	Special: Moves up one rank when first placed.	 
--17 Lanceman(Foil)	2	3	Special Attack: Deal 1 damage to Rank 2 and 3 enemies.	 
--18 Dervish(Foil)		2	5	Special Attack: Deal 0-3 damage to enemy in Rank 2 and the friendly card behind him.	 
--19 Martyr(Foil)		1	3	Special: Any damage done to the friendly card in front of Martyr is done to Martyr instead.
--20 Sniper(Foil)		1	1	Every Round: Deal 1-2 damage to rearmost enemy card.	 

--flag# = 4260 + cardnum (42601 - 42620)

--center: 450, -700, 0
--p1:	500,-700,0 +20(x)
--p2:	400,-700,0 -20(x)



--Rank 1 cards attack each other
--Rank 1 cards perform special attacks (if applicable)
--Death caused by rank 1 attacks are removed
--Sniper shoots
--Death caused by sniper are removed
--Nurse and Cleric heal. Whichever is in lower rank heals first.

function EVENT_SPAWN(self)
	turn = 1
	
	player_one = self
	player_two = self

	player_one_alive = true
	player_two_alive = true
	
	game_in_progress = false
	selection_phase = false
	
	ALL_MOBS = {}
	
	card = {}
	card[1] = {"Liodreth Alchemist",math.random(5),5,0}
	card[2] = {"Newport Guard",math.random(2),6,0}
	card[3] = {"Halas Halberdier",4,4,0}
	card[4] = {"Mad Yiv Bomber",2,1,1}
	card[5] = {"Tal`yan Ninja",8,1,0}
	card[6] = {"Heartlands Nurse",1,3,0}
	card[7] = {"Brownie Page",1,4,0}
	card[8] = {"Zaranth Shieldmaiden",1,4,0}
	card[9] = {"Shojar's Spearman",3,5,0}
	card[10] = {"Baldakan Swordsman",1 + math.random(3),5,0}
	card[11] = {"Kaladim Wall Guard",1,8,0}
	card[12] = {"Archer of the Fay",1,4,0}
	card[13] = {"Elthannar Cleric",1,1,0}
	card[14] = {"Filthy Coward",2,3,0}
	card[15] = {"Oggok Stonecrusher",0,5,1}
	card[16] = {"Centaur Warrior",2,5,0}
	card[17] = {"Athican Pikeman",2,3,1}
	card[18] = {"Chaotic Tentacle",2,5,1}
	card[19] = {"Rivervale Martyr",1,3,0}
	card[20] = {"Darkwood Sniper",1,1,0}

	model = {}   --race,gender,texture,size,weapon
	model[1] = {23,1,1,2,6034,0}		--kerran
	model[2] = {71,0,1,2,3028,3027}		--newport citizen
	model[3] = {2,0,1,3,1095,0}			--barbarian
	model[4] = {137,2,0,2,4851,0}		--kunark goblin
	model[5] = {131,2,1,2,5025,5025}		--sarnak
	model[6] = {243,2,0,2,0,9200}		--naiad
	model[7] = {15,0,0,1,0,1331}			--brownie
	model[8] = {183,1,2,2,0,1116}			--coldain
	model[9] = {133,2,1,2,5204,0}			--lycan
	model[10] = {339,0,0,2,18260,0}			--def pirate
	model[11] = {94,0,0,2,0,6020}			--kaladim cit
	model[12] = {112,1,0,2,3596,0}			--fayguard
	model[13] = {77,0,0,2,20777,1119}			--neriak cit
	model[14] = {55,0,0,2,0,0}			--beggar
	model[15] = {93,0,0,2,6140,0}			--oggok guard 3970
	model[16] = {16,2,0,2,13134,0}			--centaur
	model[17] = {106,0,1,2,3558,0}			--felguard
	model[18] = {68,2,0,2,0,0}			--tt
	model[19] = {82,2,0,2,0,1043}			--scarecrow
	model[20] = {396,2,0,2,0,0}			--kyv hunter	
	--[[
	model = {}   --race,gender,texture,size,weapon
	model[1] = {23,1,1,12,6034,0}		--kerran
	model[2] = {71,0,1,10,3028,3027}		--newport citizen
	model[3] = {2,0,1,14,1095,0}			--barbarian
	model[4] = {137,2,0,10,4851,0}		--kunark goblin
	model[5] = {131,2,1,10,5025,5025}		--sarnak
	model[6] = {243,2,0,10,0,9200}		--naiad
	model[7] = {15,0,0,8,0,1331}			--brownie
	model[8] = {183,1,2,10,0,1116}			--coldain
	model[9] = {133,2,1,10,5204,0}			--lycan
	model[10] = {339,0,0,10,18260,0}			--def pirate
	model[11] = {94,0,0,10,0,6020}			--kaladim cit
	model[12] = {112,1,0,10,3596,0}			--fayguard
	model[13] = {77,0,0,10,20777,1119}			--neriak cit
	model[14] = {55,0,0,10,0,0}			--beggar
	model[15] = {93,0,0,10,6140,0}			--oggok guard 3970
	model[16] = {16,2,0,10,13134,0}			--centaur
	model[17] = {106,0,1,10,3558,0}			--felguard
	model[18] = {68,2,0,10,0,0}			--tt
	model[19] = {82,2,0,10,0,1043}			--scarecrow
	model[20] = {396,2,0,10,0,0}			--kyv hunter	
	]]--
	rules = {}
	rules[1] = "Liodreth Alchemist - Atk: 1-5, HP: 5, Abilities: None"
	rules[2] = "Newport Guard - Atk: 1-2, HP: 6, Abilities: None"
	rules[3] = "Halas Halberdier - Atk: 4, HP: 4, Abilities: None"
	rules[4] = "Mad Yiv Bomber - Atk: 2, HP: 1, Abilities: Tosses a bomb, doing 1 damage to everyone."
	rules[5] = "Tal`yan Ninja - Atk: 8, HP: 1, Abilities: None"
	rules[6] = "Heartlands Nurse - Atk: 1, HP: 2, Abilities: Heals adjacent units by 1 hitpoint every round."
	rules[7] = "Brownie Page - Atk: 1, HP: 4, Abilities: Adds 1 bonus damage to the unit in front of him."
	rules[8] = "Zaranth Shieldmaiden - Atk: 1, HP: 4, Abilities: Prevents 1 damage from any source to the unit in front of her."
	rules[9] = "Shojar's Spearman - Atk: 3, HP: 5, Abilities: None"
	rules[10] = "Baldakan Swordsman - Atk: 2-4, HP: 5, Abilities: None"
	rules[11] = "Kaladim Wall Guard - Atk: 1, HP: 8, Abilities: None"
	rules[12] = "Archer of the Fay - Atk: 1, HP: 4, Abilities: In addition to her attack, also hits the next unit in line for 3 damage."
	rules[13] = "Elthannar Cleric - Atk: 1, HP: 1, Abilities: Heals the furthest back wounded mob for up to 2 hitpoints every round."
	rules[14] = "Filthy Coward - Atk: 2, HP: 3, Abilities: Always runs behind units placed after him.	 "
	rules[15] = "Oggok Stonecrusher - Atk: 0, HP: 5, Abilities: His attack deals half his opponent's hitpoints (rounded up)."
	rules[16] = "Centaur Warrior - Atk: 2, HP: 5, Abilities: When deployed, trades places with the unit in front of him."
	rules[17] = "Athican Pikeman - Atk: 2, HP: 3, Abilities: In addition to his attack, also hits the next two units for 1 damage."
	rules[18] = "Chaotic Tentacle - Atk: 2, HP: 5, Abilities: In addition to its attack, also deals 0-3 damage to the friendly unit behind it and to the enemy unit behind his opponent."
	rules[19] = "Rivervale Martyr - Atk: 1, HP: 3, Abilities: Takes all damage intended for the unit in front of it."
	rules[20] = "Darkwood Sniper - Atk: 1, HP: 1, Abilities: After each combat round, hits the furthest back enemy unit for 1-2 damage."
	
	player = {}
	
	player[1] = {}
	player[2] = {}

	player[1]["mobs"] = {}
	player[2]["mobs"] = {}

	player[1]["cards"] = {0,0,0,0,0}
	player[2]["cards"] = {0,0,0,0,0}

	player[1]["damage"] = {0,0,0,0,0}
	player[2]["damage"] = {0,0,0,0,0}

	player[1]["hp"] = {0,0,0,0,0}
	player[2]["hp"] = {0,0,0,0,0}

	player[1]["special"] = {0,0,0,0,0}
	player[2]["special"] = {0,0,0,0,0}

	player[1]["x"] = {452,460,465,470,475}  --center+2,+8,+5 . . .
	player[2]["x"] = {448,440,435,430,425}	--center-2,-8,-5 . . .
--[[
	player[1]["x"] = {475,520,540,560,580}
	player[2]["x"] = {425,380,360,340,320}
]]--	
	function GetCardName(t)
		return card[t][1]
	end

	function GetCardDmg(t)
		if t == 1 then
			return math.random(5)
		elseif t == 2 then
			return math.random(2)
		elseif t == 10 then
			return 1 + math.random(3)
		else
			return card[t][2]
		end
	end

	function GetCardMaxHP(t)
		return card[t][3]
	end

	function GetCardCurrentHP(p,c)
		return player[p]["hp"][c]
	end

	function GetCardSpecial(t)
		return card[t][4]
	end

	function ProcessSnipers()
		for p=1,2 do
			for i=1,5 do
				if player[p]["cards"][i] == 20 then  --player p has a sniper!!!
					lastmob = 0
					for k = 5,1,-1 do
						if lastmob == 0 and GetPlayersCardNumber((p%2) + 1,k) > 0 then
							lastmob = k
							--text(self,"Sniper hits position " .. lastmob)
						end
					end
					--text(self,"verified: " .. lastmob)
					if lastmob > 0 then
						AttackAnim(player[p]["mobs"][i])
						text(self,"The sniper nails the opposing " .. GetCardName(GetPlayersCardNumber((p%2) + 1,lastmob)) .. " with a direct shot!")
						DamageCard(1 + (p%2),lastmob,1)
					end
				end
			end
		end
	end

	function ProcessHeals()
		for p=1,2 do
			for i = 1,5 do
				if player[p]["cards"][i] == 6 then  --player p has a nurse!!!
					healed = false
					CastAnim(player[p]["mobs"][i])
					for j=i-1,i+1,2 do
						if j > 0 then
							--text(self,"a " .. p .. " " .. j)
							if GetPlayersCardNumber(p,j) ~= nil and GetPlayersCardNumber(p,j) > 0 and GetCardCurrentHP(p,j) < GetCardMaxHP(player[p]["cards"][j]) then
								healed = true
								text(self,"The nurse tends to the injured " .. GetCardName(GetPlayersCardNumber(p,j)) .. "!")
								player[p]["hp"][j] = player[p]["hp"][j] + 1
							end
						end
					end
					if not healed then
						text(self, "Player " .. p .. "'s nurse found no one to heal")
					end
				end
			end
		end
		for p=1,2 do
			for i = 1,5 do
				if player[p]["cards"][i] == 13 then  --player p has a cleric!!!
					healed = false
					text(self,"The Cleric casts a healing spell on her whole team!")
					CastAnim(player[p]["mobs"][i])
					done = false
					for j=5,1,-1 do
						if not done then
							if GetPlayersCardNumber(p,j) > 0 and GetCardCurrentHP(p,j) < GetCardMaxHP(player[p]["cards"][j]) then
								healed = true
								player[p]["hp"][j] = math.min(GetCardMaxHP(player[p]["cards"][j]), player[p]["hp"][j] + math.random(2))
								done = true
							end
						end
					end
					if not healed then
						text(self, "Player " .. p .. "'s cleric found no one to heal")
					end
				end
			end
		end
	end
	function GetPlayersCardNumber(p,c)
		return player[p]["cards"][c]
	end
	function FindFreeIndex(t)
		for i=1,#t do
			if t[i] == 0 then
				return i
			end
		end
		return -1
	end
	function DamageCard(p,position,dmg)
		--debugtext(p .. ": " .. player[p]["cards"][1] .. " " .. player[p]["cards"][2] .. " " .. player[p]["cards"][3] .. " " .. player[p]["cards"][4] .. " " .. player[p]["cards"][5])
		if GetPlayersCardNumber(p,position) > 0 then
			if GetPlayersCardNumber(p,position+1) == 8 then --shieldmaiden
				text(self,"Player " .. p .. "'s Shieldmaiden blocks some of the damage!")
				dmg = dmg - 1
				if dmg < 1 then dmg = 1 end
			end
			if GetPlayersCardNumber(p,position+1) == 19 then --martyr
				text(self,"Player " .. p .. "'s Martyr takes all of the damage!")
				position = position + 1
			end
			player[p]["hp"][position] = player[p]["hp"][position] - dmg
			the_mob = player[p]["mobs"][position]
			curr_hp = GetStat(the_mob,"hp")
			if curr_hp - (100 * dmg) < 0 then real_dmg = curr_hp - 1 else real_dmg = (100 * dmg) end
			set(the_mob,"hp",curr_hp - real_dmg)
			--text(self,"Damaging player " .. p .. " position " .. position .. " by " .. dmg)
			if player[p]["hp"][position] <= 0 then
				--text(self, "Player " .. p .. "'s " .. GetCardName(GetPlayersCardNumber(p,position)) .. " has died!")
				--setanim(player[p]["mobs"][position],3)
			end
		end
	end
	
	function PlaceMob(p,m,rank)

		x_loc = player[p]["x"][rank]
		y_loc = -700
		z_loc = 0
		
		if p == 1 then 
			h = 192
		else 
			h = 64
		end
		--[[if model[m][5] == 0 and model[m][6] == 0 then
			a = customspawn({name = GetCardName(m), race = model[m][1], gender = model[m][2], texture = model[m][3], size = model[m][4]}, x_loc, y_loc, 0,h)
		elseif model[m][5] == 0 then
			a = customspawn({name = GetCardName(m), race = model[m][1], gender = model[m][2], texture = model[m][3], size = model[m][4], weapon2 = model[m][6]}, x_loc, y_loc, 0,h)
		elseif model[m][6] == 0 then
			a = customspawn({name = GetCardName(m), race = model[m][1], gender = model[m][2], texture = model[m][3], size = model[m][4], weapon1 = model[m][5]}, x_loc, y_loc, 0,h)
		else]] 
		a = customspawn({name = GetCardName(m), hp = 1 + (100 * GetCardMaxHP(m)), level = 65, race = model[m][1], gender = model[m][2], texture = model[m][3], size = model[m][4], weapon1 = model[m][5], weapon2 = model[m][6]}, x_loc, y_loc, 0,h)
		set(a,"hpregen",0)
		invul(a,true)
		--end
		player[p]["mobs"][rank] = a
		table.insert(ALL_MOBS,a)
	end

	function PlaceCard(p,value)
	--center: 450, -700, 0
	--p1:	500,-700,0 +20(x)
	--p2:	400,-700,0 -20(x)
		index = FindFreeIndex(player[p]["cards"])
		if index > 0 then
			--debugtext("Player " .. p .. " attempts to place a " .. GetCardName(value) .. " into position " .. index .. ".")
			player[p]["cards"][index] = value
			player[p]["damage"][index] = GetCardDmg(value)
			player[p]["hp"][index] = GetCardMaxHP(value)
			player[p]["special"][index] = GetCardSpecial(value)
			PlaceMob(p,value,index)
			return true
		end
		return false
	end

	function ProcessCoward()
		for p=1,2 do --14,16
			for i=1,5 do
				if GetPlayersCardNumber(p,i) == 14 and i == 5 then --horseman found
					text(self,"The Coward cringes at the bank rank.")
				elseif GetPlayersCardNumber(p,i) == 14 and GetPlayersCardNumber(p,i+1) > 0 then --coward found
					cindex = i
					text(self,"The Coward rushes to hide behind the " .. GetCardName(GetPlayersCardNumber(p,i+1)) .. "!")
					if p == 1 then 
						heading = 192
					else 
						heading = 64
					end
					walkto(player[p]["mobs"][cindex], player[p]["x"][cindex+1],-700,0,heading)
					walkto(player[p]["mobs"][cindex+1], player[p]["x"][cindex],-700,0,heading)
					
					tempcard = player[p]["cards"][cindex]
					tempdmg = player[p]["damage"][cindex]
					temphp = player[p]["hp"][cindex]
					tempspecial = player[p]["special"][cindex]
					tempmob = player[p]["mobs"][cindex]
					
					player[p]["cards"][cindex] = player[p]["cards"][cindex+1]
					player[p]["damage"][cindex] = player[p]["damage"][cindex+1]
					player[p]["hp"][cindex] = player[p]["hp"][cindex+1]
					player[p]["special"][cindex] = player[p]["special"][cindex+1]
					player[p]["mobs"][cindex] = player[p]["mobs"][cindex+1]
					
					player[p]["cards"][cindex+1] = tempcard
					player[p]["damage"][cindex+1] = tempdmg
					player[p]["hp"][cindex+1] = temphp
					player[p]["special"][cindex+1] = tempspecial
					player[p]["mobs"][cindex+1] = tempmob
				end
			end
		end
	end
	
	function ProcessHorseman()
		for p=1,2 do --14,16
			for i=1,5 do
				if GetPlayersCardNumber(p,i) == 16 and i == 1 then --horseman found
					text(self,"The Centaur looks confused.")
				elseif GetPlayersCardNumber(p,i) == 16 and GetPlayersCardNumber(p,i-1) > 0 and GetPlayersCardNumber(p,i-1) ~= 14 then --horseman found
					hindex = i
					--debugtext("player: " .. p .. " position: " .. i)
					text(self,"The Centaur charges forward while the " .. GetCardName(GetPlayersCardNumber(p,i-1)) .. " moves back a rank!")
					if p == 1 then 
						heading = 192
					else 
						heading = 64
					end
					walkto(player[p]["mobs"][hindex], player[p]["x"][hindex-1],-700,0,heading)
					walkto(player[p]["mobs"][hindex-1], player[p]["x"][hindex],-700,0,heading)
					
					tempcard = player[p]["cards"][hindex]
					tempdmg = player[p]["damage"][hindex]
					temphp = player[p]["hp"][hindex]
					tempspecial = player[p]["special"][hindex]
					tempmob = player[p]["mobs"][hindex]
					
					player[p]["cards"][hindex] = player[p]["cards"][hindex-1]
					player[p]["damage"][hindex] = player[p]["damage"][hindex-1]
					player[p]["hp"][hindex] = player[p]["hp"][hindex-1]
					player[p]["special"][hindex] = player[p]["special"][hindex-1]
					player[p]["mobs"][hindex] = player[p]["mobs"][hindex-1]
					
					player[p]["cards"][hindex-1] = tempcard
					player[p]["damage"][hindex-1] = tempdmg
					player[p]["hp"][hindex-1] = temphp
					player[p]["special"][hindex-1] = tempspecial
					player[p]["mobs"][hindex-1] = tempmob
				end
			end
		end
	end
	
	function debugSummary()
		text(self, "Player 1 summary:")
		for i=1,5 do
			if player[1]["cards"][i] > 0 then
				text(self, GetCardName(player[1]["cards"][i]) .. " (" .. GetCardCurrentHP(1,i) .. "/" .. GetCardMaxHP(player[1]["cards"][i]) .. ")")
			end
		end
		text(self, "Player 2 summary:")
		for i=1,5 do
			if player[2]["cards"][i] > 0 then
				text(self, GetCardName(player[2]["cards"][i]) .. " (" .. GetCardCurrentHP(2,i) .. "/" .. GetCardMaxHP(player[2]["cards"][i]) .. ")")
			end
		end
	end
	
	function AttackAnim(mob)
		doanim(mob,2)
	end
	
	function DamageAnim(mob)
		doanim(mob,14)
	end
	
	function CastAnim(mob)
		doanim(mob,25)
	end
	
	function DoSpecialAttacks()  --4,8,12,15,17,18
		--text(self,"AAAA")
		for p=1,2 do
			if player[p]["special"][1] > 0 then
				if GetPlayersCardNumber(p,1) == 4 then  --mad bomber
					CastAnim(player[p]["mobs"][1])
					text(self,"The Mad Yiv Bomber EXPLODES!!!  All participants take damage!")
					for i=1,5 do
						--text(self, "i = " .. i)
						DamageCard(p,i,1)
						DamageCard((p%2) + 1,i,1)
					end
				elseif GetPlayersCardNumber(p,1) == 12 then
					AttackAnim(player[p]["mobs"][1])
					if player[(p%2) + 1]["cards"][2] > 0 then
						text(self, "The Fay Archer puts a well-aimed arrow into the opposing " .. GetCardName(GetPlayersCardNumber((p%2) + 1,2)) .. "!!")
					end
					DamageCard((p%2) + 1,2,3)
				elseif GetPlayersCardNumber(p,1) == 15 then
					AttackAnim(player[p]["mobs"][1])
					temp_dmg = GetCardMaxHP(player[(p%2) + 1]["cards"][1])
					if temp_dmg % 2 == 1 then temp_dmg = (temp_dmg + 1) / 2 else temp_dmg = temp_dmg / 2 end
					text(self,"The Skullcrusher swings again, CRUSHING the opposing " .. GetCardName(GetPlayersCardNumber((p%2) + 1,1)) .. "!!")
					DamageCard((p%2) + 1,1,temp_dmg) --deal 1/2 maxhp rounded up
				elseif GetPlayersCardNumber(p,1) == 17 then
					if player[(p%2) + 1]["cards"][2] > 0 then
						text(self,"The Pikeman spears the fighters behind the opposing " .. GetCardName(GetPlayersCardNumber((p%2) + 1,1)) .. "!!")
					end
					AttackAnim(player[p]["mobs"][1])
					DamageCard((p%2) + 1,2,1)
					DamageCard((p%2) + 1,3,1)
				elseif GetPlayersCardNumber(p,1) == 18 then
					if player[(p%2) + 1]["cards"][2] > 0 or player[p]["cards"][2] > 0 then
						text(self,"The Tentacle spins wildly, damaging surrounding fighters!!")
					end
					AttackAnim(player[p]["mobs"][1])
					DamageCard((p%2) + 1,2,math.random(4) - 1)
					DamageCard(p,2,math.random(4) - 1)
				end
			end
		end
	end

	function DoBasicAttacks()
		player_one_damage = GetCardDmg(GetPlayersCardNumber(1,1))
		if player[1]["cards"][2] == 7 then
			text(self, "Player 1's Brownie Page adds bonus damage!")
			player_one_damage = player_one_damage + 1 --page bonus (card 7 in rank 2)
		end
		AttackAnim(player[1]["mobs"][1])
		AttackAnim(player[2]["mobs"][1])
		DamageCard(2,1,player_one_damage)
		player_two_damage = GetCardDmg(GetPlayersCardNumber(2,1))
		if player[2]["cards"][2] == 7 then
			text(self, "Player 2's Brownie Page adds bonus damage!")
			player_two_damage = player_two_damage + 1 --page bonus (card 7 in rank 2)
		end
		DamageCard(1,1,player_two_damage)
	end

	function ClearDeadCards()
		for p = 1, 2 do
			--debugtext("Clearing dead for Player " .. p .. ": " .. player[p]["cards"][1] .. " " .. player[p]["cards"][2] .. " " .. player[p]["cards"][3] .. " " .. player[p]["cards"][4] .. " " .. player[p]["cards"][5])
			for i=1,5 do
				if player[p]["hp"][i] > 0 then
					alive = true
				end
			end
			if not alive then
				--debugtext("Player is out.")
			else
				repeat
					done = true
					for i=1,5 do
						if GetPlayersCardNumber(p,i) > 0 and player[p]["hp"][i] <= 0 then
							setanim(player[p]["mobs"][i],3)
							text(self, "Player " .. p .. "'s " .. GetCardName(GetPlayersCardNumber(p,i)) .. " has died!")
							--text(self, "found dead card player " .. p .. " position " .. i)
							done = false
							for j=i+1,5 do
								--debugtext("a: j is " .. j .. " and i is " .. i)
								if player[p]["cards"][j] > 0 then
									walkto(player[p]["mobs"][j],player[p]["x"][j-1],-700,0)
								end
							end
							for j=i,4 do
								--debugtext("b: j is " .. j .. " and i is " .. i)
								player[p]["cards"][j] = player[p]["cards"][j+1]
								player[p]["hp"][j] = player[p]["hp"][j+1]
								player[p]["damage"][j] = player[p]["damage"][j+1]
								player[p]["special"][j] = player[p]["special"][j+1]
								player[p]["mobs"][j] = player[p]["mobs"][j+1]
							end
							player[p]["cards"][5] = 0
							player[p]["hp"][5] = 0
							player[p]["damage"][5] = 0
							player[p]["special"][5] = 0
							player[p]["mobs"][5] = 0
						end
					end
				until done
			end
			alive = false
			--debugSummary()
			for i=1,5 do
				if player[p]["hp"][i] > 0 then
					alive = true
				end
			end
			if not alive then
				game_in_progress = false
				if p == 1 then
					player_one_alive = false
				elseif p == 2 then
					player_two_alive = false
				end
				--debugtext("Player " .. p .. " is out.")
			end
		end
	end
	function CombatLoop()
		if game_in_progress then
			DoRound()
			self:timer("do_a_round",12000,true)
		else
			if player_one_alive and not player_two_alive then
				zonetext("The match has ended and " .. gn[1] .. " is the victor!  Congratulations!")
			elseif not player_one_alive and player_two_alive then
				zonetext("The match has ended and " .. gn[2] .. " is the victor!  Congratulations!")
			elseif not player_one_alive and not player_two_alive then
				zonetext("The match has ended and Ladies and Gentlemen, we have a tie!  Well fought to both sides!")
			end
			for i=1,#ALL_MOBS do
				depop(ALL_MOBS[i])
			end
			respawn(self)
		end
	end
	
	function DoRound()
		self:timer("basic",1000,true)
		self:timer("special",2000,true)
		self:timer("clear_one",5000,true)
		self:timer("snipers",7000,true)
		self:timer("clear_two",8000,true)
		self:timer("heals",10000,true)
	end
end

function EVENT_TIMER(self,words)
	if string.find(words,"do_a_round") then
		CombatLoop()
	elseif string.find(words,"basic") then
		DoBasicAttacks()
	elseif string.find(words,"special") then
		DoSpecialAttacks()
	elseif string.find(words,"clear_one") then
		ClearDeadCards()
	elseif string.find(words,"snipers") then
		ProcessSnipers()
	elseif string.find(words,"clear_two") then
		ClearDeadCards()
	elseif string.find(words,"heals") then
		ProcessHeals()
		text(self,"Round Ends")
	end
end

--[[function EVENT_SAY(self,other,words)
	if string.find(words,"setup") then
		for i=1,5 do
			PlaceCard(1,((i-1) * 4) + math.random(4))
			PlaceCard(2,((i-1) * 4) + math.random(4))
		end
	end
	if string.find(words,"round") then
		DoRound()
	end
	if string.find(words,"summary") then
		--debugSummary()
	end
end]]

function EVENT_SAY(self, other, message)
	if string.find(message,"Hail") and not game_in_progress then
		text(self,"The Arena Master addresses you in a friendly manner: 'Here to try your luck, are you?  Well find a friend to compete against and " .. saylink("sign up",99) .. " as a group of two.  It's fun for all ages!'",other)
	end
	if string.find(message,"sign me up") and not game_in_progress then
		g = GetGroup(other,"entity")
		gn = GetGroup(other,"name")
		if not InGroup(other) or #g ~= 2 or #gn ~= 2 then
			text(self,"The Arena Master is pleased! 'You and your friend need to be in your group and only the two of you.. to avoid cheating, you know.  Let me know when you are all set and I will " .. saylink("sign you up",99) .. "!'",other)
		else
			say(self,"Great!  Turns are played simultaneously, so turn order doesn't matter.  But for now, we'll say that " .. gn[1] .. " is Player 1 and " .. gn[2] .. " is Player 2, okay?")
			say(self,"Now, it's Player 1's turn.  Come here and tell me who to deploy!  Don't say it out loud, that'll give your friend a huge advantage!")
			placed = 0
			game_in_progress = true
			selection_phase = true
			player_one = g[1]
			player_two = g[2]
		end
	end
	if string.find(message,"Hail") and game_in_progress and other == player_one and turn == 1 and selection_phase then
		text(self,"Which combatant will you summon to the field?",other)
		text(self,"1) " .. saylink("Liodreth Alchemist",1) .. "    2) " .. saylink("Newport Guard",2) .. " 3) " .. saylink("Halas Halberder",3),other)
		text(self,"4) " .. saylink("Mad Yiv Bomber",4) .. "   5) " .. saylink("Tal`yan Ninja",5) .. " 6) " .. saylink("Heartlands Nurse",6),other)
		text(self,"7) " .. saylink("Brownie Page",7) .. "       8) " .. saylink("Zaranth Shieldmaiden",8) .. " 9) " .. saylink("Shojar's Spearman",9),other)
		text(self,"10) " .. saylink("Baldakan Swordsman",10) .. "   11) " .. saylink("Kaladim Wall Guard",11) .. " 12) " .. saylink("Archer of the Fae",12),other)
		text(self,"13) " .. saylink("Elthannar Cleric",13) .. "   14) " .. saylink("Filthy Coward",14) .. " 15) " .. saylink("Oggok Skullcrusher",15),other)
		text(self,"16) " .. saylink("Centaur Warrior",16) .. " 17) " .. saylink("Athica Pikeman",17) .. " 18) " .. saylink("Chaotic Tentacle",18),other)
		text(self,"19) " .. saylink("Rivervale Martyr",19) .. " or 20) " .. saylink("Darkwood Sniper",20) .. "?",other)
		text(self,"Or would you like a card " .. saylink("explained",30) .. "?",other)
	end
	if string.find(message,"Hail") and game_in_progress and other == player_two and turn == 2 and selection_phase then
		text(self,"Which combatant will you summon to the field?",other)
		text(self,"1) " .. saylink("Liodreth Alchemist",1) .. "    2) " .. saylink("Newport Guard",2) .. " 3) " .. saylink("Halas Halberder",3),other)
		text(self,"4) " .. saylink("Mad Yiv Bomber",4) .. "   5) " .. saylink("Tal`yan Ninja",5) .. " 6) " .. saylink("Heartlands Nurse",6),other)
		text(self,"7) " .. saylink("Brownie Page",7) .. "       8) " .. saylink("Zaranth Shieldmaiden",8) .. " 9) " .. saylink("Shojar's Spearman",9),other)
		text(self,"10) " .. saylink("Baldakan Swordsman",10) .. "   11) " .. saylink("Kaladim Wall Guard",11) .. " 12) " .. saylink("Archer of the Fae",12),other)
		text(self,"13) " .. saylink("Elthannar Cleric",13) .. "   14) " .. saylink("Filthy Coward",14) .. " 15) " .. saylink("Oggok Skullcrusher",15),other)
		text(self,"16) " .. saylink("Centaur Warrior",16) .. " 17) " .. saylink("Athica Pikeman",17) .. " 18) " .. saylink("Chaotic Tentacle",18),other)
		text(self,"19) " .. saylink("Rivervale Martyr",19) .. " or 20) " .. saylink("Darkwood Sniper",20) .. "?",other)
		text(self,"Or would you like a card " .. saylink("explained",30) .. "?",other)
	end
	if string.find(message,"explanation") and game_in_progress and other == player_one and turn == 1 and selection_phase then
		text(self,"Which would you like explained?",other)
		text(self,"1) " .. saylink("Liodreth Alchemist",101) .. "    2) " .. saylink("Newport Guard",102) .. " 3) " .. saylink("Halas Halberder",103),other)
		text(self,"4) " .. saylink("Mad Yiv Bomber",104) .. "   5) " .. saylink("Tal`yan Ninja",105) .. " 6) " .. saylink("Heartlands Nurse",106),other)
		text(self,"7) " .. saylink("Brownie Page",107) .. "       8) " .. saylink("Zaranth Shieldmaiden",108) .. " 9) " .. saylink("Shojar's Spearman",109),other)
		text(self,"10) " .. saylink("Baldakan Swordsman",110) .. "   11) " .. saylink("Kaladim Wall Guard",111) .. " 12) " .. saylink("Archer of the Fae",112),other)
		text(self,"13) " .. saylink("Elthannar Cleric",113) .. "   14) " .. saylink("Filthy Coward",114) .. " 15) " .. saylink("Oggok Skullcrusher",115),other)
		text(self,"16) " .. saylink("Centaur Warrior",116) .. " 17) " .. saylink("Athica Pikeman",117) .. " 18) " .. saylink("Chaotic Tentacle",118),other)
		text(self,"19) " .. saylink("Rivervale Martyr",119) .. " or 20) " .. saylink("Darkwood Sniper",120) .. "?",other)
	end
	if string.find(message,"explanation") and game_in_progress and other == player_two and turn == 2 and selection_phase then
		text(self,"Which would you like explained?",other)
		text(self,"1) " .. saylink("Liodreth Alchemist",101) .. "    2) " .. saylink("Newport Guard",102) .. " 3) " .. saylink("Halas Halberder",103),other)
		text(self,"4) " .. saylink("Mad Yiv Bomber",104) .. "   5) " .. saylink("Tal`yan Ninja",105) .. " 6) " .. saylink("Heartlands Nurse",106),other)
		text(self,"7) " .. saylink("Brownie Page",107) .. "       8) " .. saylink("Zaranth Shieldmaiden",108) .. " 9) " .. saylink("Shojar's Spearman",109),other)
		text(self,"10) " .. saylink("Baldakan Swordsman",110) .. "   11) " .. saylink("Kaladim Wall Guard",111) .. " 12) " .. saylink("Archer of the Fae",112),other)
		text(self,"13) " .. saylink("Elthannar Cleric",113) .. "   14) " .. saylink("Filthy Coward",114) .. " 15) " .. saylink("Oggok Skullcrusher",115),other)
		text(self,"16) " .. saylink("Centaur Warrior",116) .. " 17) " .. saylink("Athica Pikeman",117) .. " 18) " .. saylink("Chaotic Tentacle",118),other)
		text(self,"19) " .. saylink("Rivervale Martyr",119) .. " or 20) " .. saylink("Darkwood Sniper",120) .. "?",other)
	end
	if string.find(message,"Hail") and game_in_progress and other == player_two and turn == 1 and selection_phase then
		text(self,"It's " .. gn[1] .. "'s turn right now.",other)
	end
	if string.find(message,"Hail") and game_in_progress and other == player_one and turn == 2 and selection_phase then
		text(self,"It's " .. gn[2] .. "'s turn right now.",other)
	end
	if string.find(message,"playcard") and game_in_progress and other == player_one and turn == 1 and selection_phase then
		player_1_card_to_play = tonumber(string.sub(message,string.find(message,"d") + 1,string.find(message,"x") - 1))
		valid = true
		for i=1,5 do
			if GetPlayersCardNumber(1,i) == player_1_card_to_play then
				valid = false
			end
		end
		if not valid then
			text(self,"The Arena Master explains patiently: 'Your team may not have duplicate members.'",other)
		else
			text(self,"The Arena Master nods.  'Excellent choice.  Now it's your friend's turn!'",other)
			turn = 2
			text(self,"The Arena Master looks at " .. gn[2] .. ". Your turn!  Come tell me what you want to deploy!",200)
		end
	end
	if string.find(message,"rules") and game_in_progress and other == player_two and turn == 2 and selection_phase then
		explaincard = tonumber(string.sub(message,string.find(message,"s") + 1,string.find(message,"q") - 1)) - 100
		text(self,rules[explaincard],other)
	end
	if string.find(message,"rules") and game_in_progress and other == player_one and turn == 1 and selection_phase then
		explaincard = tonumber(string.sub(message,string.find(message,"s") + 1,string.find(message,"q") - 1)) - 100
		text(self,rules[explaincard],other)
	end
	if string.find(message,"playcard") and game_in_progress and other == player_two and turn == 2 and selection_phase then
		player_2_card_to_play = tonumber(string.sub(message,string.find(message,"d") + 1,string.find(message,"x") - 1))
		valid = true
		for i=1,5 do
			if GetPlayersCardNumber(2,i) == player_2_card_to_play then
				valid = false
			end
		end
		if not valid then
			text(self,"The Arena Master explains patiently: 'Your team may not have duplicate members.'",other)
		else
			text(self,"The Arena Master nods.  'Excellent choice.  Let's get these fighters on the field!'",other)
			say(self,"The selections have been made!  For " .. gn[1] .. ", the " .. GetCardName(player_1_card_to_play) .. "!  And for " .. gn[2] .. ", the " .. GetCardName(player_2_card_to_play) .. "!")
			turn = 1
			PlaceCard(1,player_1_card_to_play)
			if player_1_card_to_play == 16 then ProcessHorseman() end
			PlaceCard(2,player_2_card_to_play)
			if player_2_card_to_play == 16 then ProcessHorseman() end
			ProcessCoward()
			placed = placed + 1
			if placed == 5 then
				zonetext("The Arena Master's voice echoes from every wall: 'The battle between " .. gn[1] .. " and " .. gn[2] .. " will now commence!  Good luck to both teams!")
				selection_phase = false
				CombatLoop()
			end
		end
	end
	if string.find(message,"playcard") and game_in_progress and other == player_one and turn == 2 and selection_phase then
		text(self,"It's " .. gn[2] .. "'s turn right now.",other)
	end
	if string.find(message,"playcard") and game_in_progress and other == player_two and turn == 1 and selection_phase then
		text(self,"It's " .. gn[1] .. "'s turn right now.",other)
	end
end

function EVENT_SAYLINK(self, other, id)
	if id < 30 then
		say(other,"I have made my decision!")
		EVENT_SAY(self,other,"playcard" .. id .. "xyz")
	elseif id == 30 then
		EVENT_SAY(self,other,"explanation")
	elseif id == 99 then
		say(other,"That sounds like fun, sign me up!")
		EVENT_SAY(self,other,"sign me up")
	elseif id > 100 then
		EVENT_SAY(self,other,"rules" .. id .. "q")
	end
end
