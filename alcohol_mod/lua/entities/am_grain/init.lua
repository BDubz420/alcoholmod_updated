AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local cssGrainCrate = "models/props/cs_office/cardboard_box01.mdl"
local grainModel = util.IsValidModel( cssGrainCrate ) and cssGrainCrate or "models/props_junk/garbage_bag001a.mdl"
local grainScale = util.IsValidModel( cssGrainCrate ) and 0.7 or 0.85

function ENT:Initialize()
	self:SetModel ( grainModel )
	self:SetModelScale( grainScale )
	self:PhysicsInit (SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction ( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create ( "am_grain" )
	ent:SetPos(spawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end
