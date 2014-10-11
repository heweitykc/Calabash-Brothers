package com.game.remark.model
{
    import com.f1.manager.*;

    public class RemarkRoleCfgObj extends Object
    {
        private var _map:Object;
        private var _kind:Object;
        private static var _inst:RemarkRoleCfgObj;

        public function RemarkRoleCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_activation_attribute");
            this._kind = {};
            this.sort();
            return;
        }// end function

        public function getId(param1:int) : Object
        {
            return this._map[param1];
        }// end function

        private function sort() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:* = 0;
            for (_loc_1 in this._map)
            {
                
                if (this._kind[_loc_4[_loc_1].q_type] == null)
                {
                    this._kind[_loc_4[_loc_1].q_type] = [];
                }
                (this._kind[_loc_4[_loc_1].q_type] as Array).push(_loc_4[_loc_1]);
            }
            for (_loc_1 in this._kind)
            {
                
                _loc_2 = 0;
                while (_loc_2 < _loc_4[_loc_1].length)
                {
                    
                    _loc_4[_loc_1][_loc_2].q_param = int(_loc_4[_loc_1][_loc_2].q_param);
                    _loc_2++;
                }
                (_loc_4[_loc_1] as Array).sortOn("q_param", Array.NUMERIC);
            }
            return;
        }// end function

        public function getRemark(param1:int, param2:int = 1) : Object
        {
            if (this._kind[param2])
            {
                if (param1 > -1 && param1 <= (this._kind[param2].length - 1))
                {
                    return this._kind[param2][param1];
                }
            }
            return null;
        }// end function

        public function getObjByType(param1:int, param2:String) : Object
        {
            var _loc_3:* = 0;
            if (this._kind[param1])
            {
                _loc_3 = 0;
                while (_loc_3 < this._kind[param1].length)
                {
                    
                    if (this._kind[param1][_loc_3].q_param == param2)
                    {
                        return this._kind[param1][_loc_3];
                    }
                    _loc_3++;
                }
            }
            return null;
        }// end function

        public function getLevelUp(param1:int, param2:int = 1) : int
        {
            if (this._kind[param2])
            {
                if (param1 > -1 && param1 <= (this._kind[param2].length - 1))
                {
                    return param1;
                }
            }
            return -1;
        }// end function

        public function getSatisfyInfo(param1:int, param2:String) : int
        {
            var _loc_5:* = 0;
            var _loc_3:* = "";
            var _loc_4:* = -1;
            if (this._kind[param1])
            {
                _loc_5 = 0;
                while (_loc_5 < this._kind[param1].length)
                {
                    
                    if (int(param2) < int(this._kind[param1][_loc_5].q_param))
                    {
                        _loc_3 = this._kind[param1][_loc_5].q_param;
                        return --_loc_5;
                    }
                    _loc_5++;
                }
            }
            return (this._kind[param1].length - 1);
        }// end function

        public static function getInstance() : RemarkRoleCfgObj
        {
            var _loc_1:* = new RemarkRoleCfgObj;
            _inst = new RemarkRoleCfgObj;
            return _inst || _loc_1;
        }// end function

    }
}
