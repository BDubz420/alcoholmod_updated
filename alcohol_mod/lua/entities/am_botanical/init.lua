AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local cssBotanicalCrate = "models/props/cs_italy/fruit_crate1.mdl"
local botanicalModel = util.IsValidModel( cssBotanicalCrate ) and cssBotanicalCrate or "models/props_junk/PlasticCrate01a.mdl"
local botanicalScale = util.IsValidModel( cssBotanicalCrate ) and 0.9 or 0.85

function ENT:Initialize()
	self:SetModel ( botanicalModel )
	self:SetModelScale( botanicalScale )
	self:PhysicsInit (SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction ( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create ( "am_botanical" )
	ent:SetPos(spawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end
