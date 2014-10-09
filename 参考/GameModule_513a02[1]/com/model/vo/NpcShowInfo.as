package com.model.vo
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.game.map.bean.*;
    import com.staticdata.*;

    public class NpcShowInfo extends RoleInfo
    {
        private var _icon:String;

        public function NpcShowInfo()
        {
            _roleType = RoleType.ROLE_TYPE_NPC;
            return;
        }// end function

        public function set npcInfo(param1:NpcInfo) : void
        {
            _cfgId = param1.npcModelId;
            _personId = param1.npcId;
            _dir = param1.dir;
            _name = param1.npcName;
            this._icon = param1.npcIcon;
            showID = param1.npcRes;
            _x = param1.x;
            _y = param1.y;
            var _loc_2:* = NpcCfgObj.getInstance().getNpcByID("" + _cfgId);
            if (!_loc_2)
            {
                return;
            }
            showID = _loc_2._npcRes;
            _name = _loc_2._npcName;
            _dir = _loc_2._dir;
            return;
        }// end function

    }
}
