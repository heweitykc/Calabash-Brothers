package com.game.autopk.controller
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.game.autopk.*;
    import com.game.autopk.model.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class DrinkLogic extends Object
    {
        private var drinkTime:Number = 0;
        private const SPACE_TIME:Number = 100;
        public static const BLOOD_IDS:Array = [100002, 100003, 100004, 100087];
        public static const MAGIC_IDS:Array = [100005, 100006, 100007];

        public function DrinkLogic()
        {
            return;
        }// end function

        public function autoDrink(param1:Boolean) : void
        {
            var _loc_2:* = RoleList.getInstance().player;
            if (param1)
            {
                _loc_2.info.addEvtListener(RoleEvent.UPDATE_HP, this.onPlayerHpChange);
                _loc_2.info.addEvtListener(RoleEvent.UPDATE_MP, this.onPlayerMpChange);
            }
            else
            {
                _loc_2.info.removeEvtListener(RoleEvent.UPDATE_HP, this.onPlayerHpChange);
                _loc_2.info.removeEvtListener(RoleEvent.UPDATE_MP, this.onPlayerMpChange);
                this.setAuto(false);
            }
            return;
        }// end function

        private function onPlayerHpChange(event:RoleEvent) : void
        {
            if (!AutoFightModel.autohp)
            {
                return;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo;
            var _loc_3:* = 100 * _loc_2.HP / _loc_2.HPMax;
            var _loc_4:* = 100 * _loc_2.MP / _loc_2.MPMax;
            if (_loc_3 < AutoFightModel.hp)
            {
                this.drinkHp();
                this.setAuto(true);
            }
            else if (_loc_4 >= AutoFightModel.mp)
            {
                this.setAuto(false);
            }
            return;
        }// end function

        private function onPlayerMpChange(event:RoleEvent) : void
        {
            if (!AutoFightModel.automp)
            {
                return;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo;
            var _loc_3:* = 100 * _loc_2.MP / _loc_2.MPMax;
            var _loc_4:* = 100 * _loc_2.HP / _loc_2.HPMax;
            if (_loc_3 < AutoFightModel.mp)
            {
                this.drinkMp();
                this.setAuto(true);
            }
            else if (_loc_4 >= AutoFightModel.hp)
            {
                this.setAuto(false);
            }
            return;
        }// end function

        private function setAuto(param1:Boolean) : void
        {
            if (param1)
            {
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            else
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this.drinkTime < this.SPACE_TIME)
            {
                return;
            }
            this.drinkTime = _loc_2;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(100002);
            var _loc_4:* = CDManager.getInstance().getCD(CDTypes.DRUG, 100002, _loc_3.q_cooldown_level);
            if (_loc_4[0] <= 0)
            {
                this.drinkHp();
            }
            _loc_3 = ItemCfgObj.getInstance().getCfgBy(100005);
            _loc_4 = CDManager.getInstance().getCD(CDTypes.DRUG, 100005, _loc_3.q_cooldown_level);
            if (_loc_4[0] <= 0)
            {
                this.drinkMp();
            }
            return;
        }// end function

        private function drinkHp() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (!AutoFightModel.autohp)
            {
                return;
            }
            var _loc_1:* = UserObj.getInstance().playerInfo;
            var _loc_2:* = 100 * _loc_1.HP / _loc_1.HPMax;
            if (_loc_2 < AutoFightModel.hp)
            {
                _loc_3 = BackpackObj.getInstance().getGoodsByType(2);
                if (_loc_3 && _loc_3.length)
                {
                    _loc_4 = _loc_3.length;
                    _loc_5 = BLOOD_IDS;
                    _loc_7 = _loc_5.length - 1;
                    while (_loc_7 >= 0)
                    {
                        
                        _loc_8 = 0;
                        while (_loc_8 < _loc_4)
                        {
                            
                            _loc_6 = _loc_3[_loc_8];
                            if (_loc_6.q_id == _loc_5[_loc_7] && _loc_1.level >= _loc_6.q_level)
                            {
                                BackPackControl.getInstance().useItem(_loc_6);
                                return;
                            }
                            _loc_8++;
                        }
                        _loc_7 = _loc_7 - 1;
                    }
                }
                if (AutoFightManager.getInstance().fightLogic.fighting)
                {
                    VipLogic.buyHp();
                }
            }
            return;
        }// end function

        private function drinkMp() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (!AutoFightModel.automp)
            {
                return;
            }
            var _loc_1:* = UserObj.getInstance().playerInfo;
            var _loc_2:* = 100 * _loc_1.MP / _loc_1.MPMax;
            if (_loc_2 < AutoFightModel.mp)
            {
                _loc_3 = BackpackObj.getInstance().getGoodsByType(2);
                if (_loc_3 && _loc_3.length)
                {
                    _loc_4 = _loc_3.length;
                    _loc_5 = MAGIC_IDS;
                    _loc_7 = _loc_5.length - 1;
                    while (_loc_7 >= 0)
                    {
                        
                        _loc_8 = 0;
                        while (_loc_8 < _loc_4)
                        {
                            
                            _loc_6 = _loc_3[_loc_8];
                            if (_loc_6.q_id == _loc_5[_loc_7] && _loc_1.level >= _loc_6.q_level)
                            {
                                BackPackControl.getInstance().useItem(_loc_6);
                                return;
                            }
                            _loc_8++;
                        }
                        _loc_7 = _loc_7 - 1;
                    }
                }
                if (AutoFightManager.getInstance().fightLogic.fighting)
                {
                    VipLogic.buyMp();
                }
            }
            return;
        }// end function

    }
}
