package com.model.vo
{
    import com.cfg.obj.*;
    import com.f1.utils.path.*;
    import com.game.utils.*;
    import com.staticdata.*;

    public class CutePetInfo extends RoleInfo
    {
        public var parentId:long;
        public var petType:int;

        public function CutePetInfo()
        {
            return;
        }// end function

        public function conByParentInfo(param1:RoleInfo) : void
        {
            this.parentId = new long(param1.personId.low, param1.personId.high);
            personId = new long(0, 0);
            x = param1.x + MapUtils.GRID_BORDER * 5;
            y = param1.y + MapUtils.GRID_BORDER * 5;
            mapId = param1.mapId;
            speed = param1.speed * 1;
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(param1.equipPetId);
            url = Params.ROLE_RES_PATH + _loc_2.q_equip_resource;
            this.petType = _loc_2.q_third_type;
            return;
        }// end function

    }
}
