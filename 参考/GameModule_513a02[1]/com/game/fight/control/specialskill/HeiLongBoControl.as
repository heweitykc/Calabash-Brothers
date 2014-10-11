package com.game.fight.control.specialskill
{
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class HeiLongBoControl extends Object
    {

        public function HeiLongBoControl()
        {
            return;
        }// end function

        public function checkAttackRole(param1:SkillInfo, param2:IRole) : Array
        {
            var _loc_5:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_3:* = getTimer();
            var _loc_4:* = RoleList.getInstance().roles;
            var _loc_6:* = 300;
            var _loc_7:* = param1.q_circular_radius;
            var _loc_8:* = [];
            var _loc_9:* = [];
            for each (_loc_10 in _loc_4)
            {
                
                if (_loc_10 != param2)
                {
                    _loc_5 = MapUtils.countDistance([_loc_10._x, _loc_10._y], [param2._x, param2._y]);
                    if (_loc_5 <= _loc_6)
                    {
                        _loc_8.push({dis:_loc_5, role:_loc_10});
                        continue;
                    }
                    if (_loc_5 <= _loc_7)
                    {
                        if (Math.random() < 0.5)
                        {
                            _loc_9.push({dis:_loc_5, role:_loc_10});
                        }
                    }
                }
            }
            _loc_8 = _loc_8.concat(_loc_9);
            _loc_11 = param1.q_target_max;
            if (_loc_8.length > _loc_11)
            {
                _loc_8.splice(_loc_11);
            }
            Log.log("检查黑龙波花时间", getTimer() - _loc_3);
            return _loc_8;
        }// end function

    }
}
