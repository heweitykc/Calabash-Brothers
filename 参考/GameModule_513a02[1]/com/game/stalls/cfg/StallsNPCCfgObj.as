package com.game.stalls.cfg
{
    import __AS3__.vec.*;
    import com.f1.manager.*;
    import com.game.utils.*;
    import com.model.vo.*;

    public class StallsNPCCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:StallsNPCCfgObj;

        public function StallsNPCCfgObj() : void
        {
            this._map = CfgManager.getInstance().getMap("StallsNPC");
            return;
        }// end function

        public function get map() : Object
        {
            return this._map;
        }// end function

        public function getList() : Vector.<StallsBriefInfo>
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_1:* = new Vector.<StallsBriefInfo>;
            for (_loc_2 in this._map)
            {
                
                _loc_3 = new StallsBriefInfo();
                _loc_3.isNpc = _loc_5[_loc_2].npc;
                _loc_3.playerid = long.parselong(_loc_5[_loc_2].npc);
                _loc_3.stallsname = _loc_5[_loc_2].stallsname;
                _loc_3.playername = _loc_5[_loc_2].playername;
                _loc_3.playerlv = -1;
                _loc_3.sellgoodsnum = _loc_5[_loc_2].sellnum;
                _loc_1.push(_loc_3);
            }
            return _loc_1;
        }// end function

        public static function getInstance() : StallsNPCCfgObj
        {
            if (instance == null)
            {
                instance = new StallsNPCCfgObj;
            }
            return instance;
        }// end function

    }
}
