package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class LotteryCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:LotteryCfgObj;

        public function LotteryCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("lottery");
            return;
        }// end function

        public function getLotteryList() : Vector.<Lottery>
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = new Vector.<Lottery>;
            for each (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_3.lottery_id);
                if (_loc_2 != 0)
                {
                    _loc_4 = new Lottery();
                    _loc_4.parse(_loc_3);
                    _loc_1.push(_loc_4);
                }
            }
            _loc_1.sort(this.sortIntegers);
            return _loc_1;
        }// end function

        private function sortIntegers(param1:Lottery, param2:Lottery) : Number
        {
            if (param1.lottery_id < param2.lottery_id)
            {
                return -1;
            }
            if (param1.lottery_id > param2.lottery_id)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function getInstance() : LotteryCfgObj
        {
            if (!_instance)
            {
                _instance = new LotteryCfgObj;
            }
            return _instance;
        }// end function

    }
}
