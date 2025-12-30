AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local ypos = -150

function ENT:Draw()

	if( self:GetPos():Distance( LocalPlayer():GetPos() ) > 1500 ) then return end

	self:DrawModel()

	if( self:GetPos():Distance( LocalPlayer():GetPos() ) > 500 ) then return end
	
	local ang = LocalPlayer():EyeAngles()

	local pos
    if self:LookupBone("ValveBiped.Bip01_Head1") != nil then
    	pos = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Head1")) + Vector(0,0,3)
    else 
    	pos = self:GetPos()+ Vector(0,0,68)
    end 

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	cam.Start3D2D(pos, ang, 0.11)
		draw.WordBox(6, 0, ypos +50, self:GetVendorName( ), "HUDNumber5", Color(140, 0, 0, 100), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()

	cam.Start3D2D(pos, ang, 0.05)		
		draw.WordBox(8, 0, ypos +5, "Buy and Sell your alcohol here!", "HUDNumber5", Color(140, 0, 0, 100), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end


net.Receive( "alcoholvendoropen", function( )
	local EnableBuy = net.ReadBool( EnableBuy )
	local EnableSell = net.ReadBool( EnableSell )

	local AlcoholVendorPanel = vgui.Create( "DFrame" )
	AlcoholVendorPanel:SetSize( ScrW() * 0.1, ScrH() * 0.1 )
	AlcoholVendorPanel:Center( )
	AlcoholVendorPanel:SetTitle( "Buy or Sell" )
	AlcoholVendorPanel:SetVisible( true )
	AlcoholVendorPanel:SetDraggable( true )
	AlcoholVendorPanel:ShowCloseButton( true )
	AlcoholVendorPanel:MakePopup( )
	AlcoholVendorPanel.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 160 ) )
	end

	local AVVendorPanel = vgui.Create( "DPanel", AlcoholVendorPanel )
	AVVendorPanel:Dock( FILL )
	AVVendorPanel.Paint = function() end

	local AVPBuyButton = vgui.Create( "DButton", AVVendorPanel )
	AVPBuyButton:SetText( "Buy" )
	AVPBuyButton:Dock(TOP)

	if EnableBuy then
		AVPBuyButton.DoClick = function( )
			local AVBuyFrame = vgui.Create( "DFrame" )
			AVBuyFrame:SetSize( ScrW() * 0.1, ScrH() * 0.1 )
			AVBuyFrame:Center( )
			AVBuyFrame:SetTitle( "Buy Menu" )
			AVBuyFrame:SetVisible( true )
			AVBuyFrame:SetDraggable( true )
			AVBuyFrame:ShowCloseButton( true )
			AVBuyFrame:MakePopup( )
			AVBuyFrame.Paint = function( _, w, h )
				draw.RoundedBox( 6, 0, 0, w, h, Color( 0, 0, 0, 160 ) )
			end

			AVPBuyButton:Remove( )
			AlcoholVendorPanel:Remove( )
			AVVendorPanel:Remove( )

			local AVBuyPanel = vgui.Create( "DPanel", AVBuyFrame )
			AVBuyPanel:Dock( FILL )
			AVBuyPanel.Paint = function() end

			local AVPBuyBeerButton = vgui.Create( "DButton", AVBuyPanel )
			AVPBuyBeerButton:SetText( "Buy Beer" )
			AVPBuyBeerButton:Dock( TOP )

			AVPBuyBeerButton.DoClick = function( )
				net.Start( "AVBuyBeer" )
				net.SendToServer( )
				AVBuyFrame:Remove( )
			end

			local AVPBuyWineButton = vgui.Create( "DButton", AVBuyPanel )
			AVPBuyWineButton:SetText( "Buy Wine" )
			AVPBuyWineButton:Dock( TOP )

			AVPBuyWineButton.DoClick = function( )
				net.Start( "AVBuyWine" )
				net.SendToServer( )
				AVBuyFrame:Remove( )
			end

			local AVPBuyGinButton = vgui.Create( "DButton", AVBuyPanel )
			AVPBuyGinButton:SetText( "Buy Gin" )
			AVPBuyGinButton:Dock( TOP )

			AVPBuyGinButton.DoClick = function( )
				net.Start( "AVBuyGin" )
				net.SendToServer( )
				AVBuyFrame:Remove( )
			end
		end
	else
		AVPBuyButton.DoClick = function( )
			LocalPlayer( ):ChatPrint( "Buying is disabled on this server." )
			AlcoholVendorPanel:Remove( )
		end
	end

	local AVPSellButton = vgui.Create( "DButton", AVVendorPanel )
	AVPSellButton:SetText( "Sell" )
	AVPSellButton:Dock( TOP )

	if EnableSell then
		AVPSellButton.DoClick = function( )
			net.Start( "AVSellAll" )
			net.SendToServer( )
			AlcoholVendorPanel:Remove( )
		end
	else
		AVPSellButton.DoClick = function( )
			LocalPlayer( ):ChatPrint( "Selling is disabled on this server." )
			AlcoholVendorPanel:Remove( )
		end
	end
end )
