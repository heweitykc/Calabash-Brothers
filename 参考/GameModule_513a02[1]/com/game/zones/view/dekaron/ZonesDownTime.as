package com.game.zones.view.dekaron
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.util.*;
    import flash.display.*;

    public class ZonesDownTime extends Component
    {
        private var vecTimeNumber:Vector.<MovieClip>;
        private var vecMonsterNumber:Vector.<MovieClip>;
        private var _downTime:DownTimer;
        private var _zonesDownTime:MovieClip;
        private var _zonesDownMonster:MovieClip;
        public var callDownBack:Function;
        private var _phase:int;
        private static var _instance:ZonesDownTime;

        public function ZonesDownTime()
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._zonesDownTime = ToolKit.getNew("zones_down_time_show");
            this._zonesDownMonster = ToolKit.getNew("zones_down_show_monster");
            this.addChild(this._zonesDownTime);
            this.addChild(this._zonesDownMonster);
            this.vecTimeNumber = new Vector.<MovieClip>(6, true);
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                _loc_2 = this._zonesDownTime["num" + _loc_1];
                this.vecTimeNumber[_loc_1] = _loc_2;
                _loc_2.gotoAndStop(1);
                _loc_1++;
            }
            this.vecMonsterNumber = new Vector.<MovieClip>(2, true);
            this.vecMonsterNumber[0] = this._zonesDownMonster["num0"];
            this.vecMonsterNumber[1] = this._zonesDownMonster["num1"];
            this._downTime = new DownTimer();
            this._downTime.callBack = this.callBack;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        private function callBack(param1:int, param2:String) : void
        {
            var _loc_3:* = null;
            switch(this._phase)
            {
                case 0:
                {
                    this.setDownMonster(param1);
                    break;
                }
                case 1:
                {
                    _loc_3 = this.getStr(param1);
                    this.setDownTime(_loc_3);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 <= 0)
            {
                this.close();
            }
            return;
        }// end function

        private function getStr(param1:uint) : String
        {
            var _loc_3:* = 0;
            var _loc_2:* = param1;
            var _loc_4:* = "";
            _loc_3 = _loc_2 / 60000;
            _loc_4 = _loc_4 + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3.toString()));
            _loc_2 = _loc_2 % 60000;
            _loc_3 = _loc_2 / 1000;
            _loc_4 = _loc_4 + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3.toString()));
            _loc_2 = _loc_2 % 1000;
            _loc_3 = _loc_2 / 10;
            _loc_4 = _loc_4 + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3.toString()));
            return _loc_4;
        }// end function

        private function setDownMonster(param1:int) : void
        {
            param1 = param1 / 1000;
            var _loc_2:* = param1 / 10;
            this.vecMonsterNumber[0].gotoAndStop(_loc_2 <= 0 ? (11) : ((_loc_2 + 1)));
            _loc_2 = param1 % 10;
            this.vecMonsterNumber[1].gotoAndStop((_loc_2 + 1));
            return;
        }// end function

        private function setDownTime(param1:String) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < 6)
            {
                
                this.vecTimeNumber[_loc_2].gotoAndStop((int(param1.charAt(_loc_2)) + 1));
                _loc_2++;
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.TOP_CENTER, 0, 150));
            return;
        }// end function

        public function close() : void
        {
            if (this._downTime.count > 0)
            {
                this._downTime.count = 0;
            }
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

        public function updateDownTime(param1:int, param2:int, param3:int = 10) : void
        {
            this._phase = param2;
            switch(param2)
            {
                case 0:
                {
                    this._downTime.count = param3 * 1000;
                    this._zonesDownTime.visible = false;
                    this._zonesDownMonster.visible = true;
                    break;
                }
                case 1:
                {
                    this._downTime.count = param1 * 1000;
                    this._zonesDownTime.visible = true;
                    this._zonesDownMonster.visible = false;
                    break;
                }
                case 3:
                {
                    this._downTime.count = 60 * 1000;
                    this._zonesDownTime.visible = false;
                    this._zonesDownMonster.visible = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1 > 0 && !this.parent)
            {
                this.open();
            }
            return;
        }// end function

        public static function getinstance() : ZonesDownTime
        {
            if (!_instance)
            {
                _instance = new ZonesDownTime;
            }
            return _instance;
        }// end function

    }
}
