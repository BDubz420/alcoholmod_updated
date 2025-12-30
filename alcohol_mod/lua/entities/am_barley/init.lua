AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local cssSacks = "models/props/cs_militia/sacks.mdl"
local barleyModel = util.IsValidModel( cssSacks ) and cssSacks or "models/props_junk/metal_paintcan001a.mdl"
local barleyScale = util.IsValidModel( cssSacks ) and 0.45 or 0.6

function ENT:Initialize()
	self:SetModel ( barleyModel )
	self:SetModelScale( barleyScale )
	self:PhysicsInit (SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction ( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create ( "am_barley" )
	ent:SetPos(spawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use( _, caller )
	caller:SetNWInt( "Barley", caller:GetNWInt( "Barley" ) + 1 )
	if caller:GetNWInt( "Barley" ) == 1 then
		caller:ChatPrint( "You now have 1 wad of barley." )
	elseif caller:GetNWInt( "Barley" ) > 1 then
		caller:ChatPrint( "You now have " .. caller:GetNWInt( "Barley" ) .. " wads of barley." )
	end
	self:Remove()
end
