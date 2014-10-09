package com.game.batter.model
{
    import __AS3__.vec.*;
    import com.f1.manager.*;

    public class BatterModel extends Object
    {
        private var vecTable:Vector.<BatterTableVo>;
        private static var _instance:BatterModel;

        public function BatterModel()
        {
            this.vecTable = new Vector.<BatterTableVo>;
            this.initTable();
            return;
        }// end function

        private function initTable() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = CfgManager.getInstance().getMap("batterMonsterkills");
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = new BatterTableVo();
                _loc_3.setInfo(_loc_2);
                this.vecTable.push(_loc_3);
            }
            return;
        }// end function

        public function getInfoFromId(param1:int) : BatterTableVo
        {
            var _loc_2:* = this.vecTable.length;
            param1 = param1 >= _loc_2 ? ((_loc_2 - 1)) : (param1);
            param1 = param1 < 0 ? (0) : (param1);
            return this.vecTable[param1];
        }// end function

        public function getMaxInfo() : BatterTableVo
        {
            var _loc_1:* = this.vecTable.length;
            return this.vecTable[(_loc_1 - 1)];
        }// end function

        public static function getInstance() : BatterModel
        {
            if (!_instance)
            {
                _instance = new BatterModel;
            }
            return _instance;
        }// end function

    }
}
