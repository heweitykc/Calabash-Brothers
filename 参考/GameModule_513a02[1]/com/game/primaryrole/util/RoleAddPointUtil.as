package com.game.primaryrole.util
{
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class RoleAddPointUtil extends Object
    {

        public function RoleAddPointUtil()
        {
            return;
        }// end function

        public static function getAddPoint(param1:Object, param2:int) : Object
        {
            var _loc_6:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_3:* = UserObj.getInstance().playerInfo;
            var _loc_4:* = _loc_3.unallocatedTalent;
            var _loc_5:* = {};
            var _loc_7:* = [];
            var _loc_8:* = [false, false, false, false];
            if (param2 == 0)
            {
                return null;
            }
            if (param2 == JobType.WARRIOR || param2 == JobType.KNIGHT || param2 == JobType.GODKNIGHT || param2 == JobType.GODKNIGHT_4)
            {
                _loc_7 = ["strength", "agile", "vitality", "intelligence", "str_limit", "agi_limit", "vit_limit", "int_limit"];
            }
            else if (param2 == JobType.MAGICER || param2 == JobType.SLAYER || param2 == JobType.GODSLAYER || param2 == JobType.GODSLAYER_4)
            {
                _loc_7 = ["intelligence", "agile", "vitality", "strength", "int_limit", "agi_limit", "vit_limit", "str_limit"];
            }
            else if (param2 == JobType.BOWMAN || param2 == JobType.ARCHER || param2 == JobType.GODARCHER || param2 == JobType.GODARCHER_4_)
            {
                _loc_7 = ["agile", "intelligence", "vitality", "strength", "agi_limit", "int_limit", "vit_limit", "str_limit"];
            }
            var _loc_9:* = {};
            var _loc_10:* = 0;
            while (_loc_10 < 4)
            {
                
                _loc_5[_loc_7[_loc_10]] = 0;
                _loc_9[_loc_7[_loc_10]] = _loc_3[_loc_7[[_loc_10]]];
                _loc_10++;
            }
            var _loc_11:* = false;
            while (_loc_4 > 0)
            {
                
                var _loc_15:* = _loc_4 > 5 ? (5) : (_loc_4);
                _loc_12 = _loc_4 > 5 ? (5) : (_loc_4);
                _loc_13 = _loc_15;
                _loc_10 = 0;
                while (_loc_10 < 4)
                {
                    
                    if (_loc_9[_loc_7[_loc_10]] >= int(param1[_loc_7[4 + _loc_10]]))
                    {
                        _loc_8[_loc_10] = true;
                        _loc_11 = true;
                    }
                    else if (_loc_5[_loc_7[_loc_10]] + int(param1[_loc_7[_loc_10]]) + _loc_9[_loc_7[_loc_10]] <= int(param1[_loc_7[4 + _loc_10]]) && int(param1[_loc_7[_loc_10]] <= _loc_13))
                    {
                        _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + int(param1[_loc_7[_loc_10]]);
                        _loc_13 = _loc_13 - param1[_loc_7[_loc_10]];
                    }
                    else if (_loc_5[_loc_7[_loc_10]] + int(param1[_loc_7[_loc_10]]) + _loc_9[_loc_7[_loc_10]] <= int(param1[_loc_7[4 + _loc_10]]) && int(param1[_loc_7[_loc_10]]) > _loc_13)
                    {
                        _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + _loc_13;
                        _loc_13 = 0;
                    }
                    else if (_loc_5[_loc_7[_loc_10]] + int(param1[_loc_7[_loc_10]]) + _loc_9[_loc_7[_loc_10]] > int(param1[_loc_7[4 + _loc_10]]) && int(param1[_loc_7[_loc_10]]) > _loc_13)
                    {
                        if (_loc_5[_loc_7[_loc_10]] + _loc_13 + _loc_9[_loc_7[_loc_10]] >= int(param1[_loc_7[4 + _loc_10]]))
                        {
                            _loc_13 = _loc_13 - (int(param1[_loc_7[4 + _loc_10]]) - _loc_5[_loc_7[_loc_10]] - _loc_9[_loc_7[_loc_10]]);
                            _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + (int(param1[_loc_7[4 + _loc_10]]) - _loc_5[_loc_7[_loc_10]] - _loc_9[_loc_7[_loc_10]]);
                            _loc_8[_loc_10] = true;
                            _loc_11 = true;
                            ;
                        }
                        else if (_loc_5[_loc_7[_loc_10]] + _loc_13 + _loc_9[_loc_7[_loc_10]] < int(param1[_loc_7[4 + _loc_10]]))
                        {
                            _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + _loc_13;
                            _loc_13 = 0;
                        }
                    }
                    else
                    {
                        _loc_13 = _loc_13 - (int(param1[_loc_7[4 + _loc_10]]) - _loc_5[_loc_7[_loc_10]] - _loc_9[_loc_7[_loc_10]]);
                        _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + (int(param1[_loc_7[4 + _loc_10]]) - _loc_5[_loc_7[_loc_10]] - _loc_9[_loc_7[_loc_10]]);
                        _loc_8[_loc_10] = true;
                        _loc_11 = true;
                        ;
                    }
                    _loc_10++;
                }
                _loc_4 = _loc_4 - (_loc_12 - _loc_13);
                if (_loc_11)
                {
                    break;
                }
            }
            _loc_10 = 0;
            while (_loc_10 < 4)
            {
                
                if (!_loc_8[_loc_10])
                {
                    _loc_14 = _loc_4 - (int(param1[_loc_7[4 + _loc_10]]) - _loc_5[_loc_7[_loc_10]] - _loc_9[_loc_7[_loc_10]]);
                    if (_loc_14 > 0)
                    {
                        _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + (_loc_4 - _loc_14);
                        _loc_4 = _loc_14;
                    }
                    else
                    {
                        _loc_5[_loc_7[_loc_10]] = _loc_5[_loc_7[_loc_10]] + _loc_4;
                        _loc_4 = 0;
                    }
                }
                _loc_10++;
            }
            if (_loc_4 > 0)
            {
                _loc_5[_loc_7[0]] = _loc_5[_loc_7[0]] + _loc_4;
            }
            return _loc_5;
        }// end function

    }
}
