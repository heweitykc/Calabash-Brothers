package com.game.primaryrole.cfg
{
    import com.f1.manager.*;

    public class RecommandTalentPlusObj extends Object
    {
        private var _map:Object;
        private static var _instance:RecommandTalentPlusObj;

        public function RecommandTalentPlusObj()
        {
            this._map = CfgManager.getInstance().getMap("recommend_build");
            return;
        }// end function

        public function getPlus(param1:int, param2:int) : Object
        {
            var _loc_3:* = int((param2 - 1) * 3) + (param1 - 1) % 3 + 1;
            return this._map[_loc_3];
        }// end function

        public static function getInstance() : RecommandTalentPlusObj
        {
            var _loc_1:* = new RecommandTalentPlusObj;
            _instance = new RecommandTalentPlusObj;
            return _instance || _loc_1;
        }// end function

    }
}
