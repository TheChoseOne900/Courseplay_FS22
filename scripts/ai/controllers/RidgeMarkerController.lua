--- Controls the state of the ridge markers, if the ridgeMarker setting is active.
---@class RidgeMarkerController : ImplementController
RidgeMarkerController = CpObject(ImplementController)

RidgeMarkerController.RIDGE_MARKER_NONE = 0
RidgeMarkerController.RIDGE_MARKER_LEFT = 1
RidgeMarkerController.RIDGE_MARKER_RIGHT = 2

function RidgeMarkerController:init(vehicle, implement)
    ImplementController.init(self, vehicle, implement)
    self.ridgeMarkerSpec = self.implement.spec_ridgeMarker
end

function RidgeMarkerController:update()
	if not self.settings.ridgeMarkersAutomatic:getValue() then
		self:debugSparse('Ridge marker handling disabled.')
		return
	end
	--- TODO: Disable ridge markers with convoy active ?
	local state = self.driveStrategy:getRidgeMarkerState()
	self:debugSparse('Target ridge marker state is %d.', state)
	-- yes, another Giants typo
	if self.ridgeMarkerSpec.numRigdeMarkers > 0 then
		if self.ridgeMarkerSpec.ridgeMarkerState ~= state then
			self:debug('Setting ridge markers to %d', state)
			self.implement:setRidgeMarkerState(state)
		end
	end	
end

