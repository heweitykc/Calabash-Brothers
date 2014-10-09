package com.game.redfortress.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import com.util.*;
    import flash.display.*;

    public class ZonesRedfortressDownTime extends Component
    {
        private var _downTime:DownTimer;
        public var callDownBack:Function;
        private var _content:MovieClip;
        private var _num1:MovieClip;
        private var _preStart:Sprite;
        private var _downWord:Sprite;
        private var _startEffect:MovieClip;
        private static var _instance:ZonesRedfortressDownTime;

        public function ZonesRedfortressDownTime(param1 = null, param2:String = null)
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._content = ToolKit.getNew("zones_redfortress_down_time");
            this._startEffect = ToolKit.getNew("zones_redfortress_start");
            this.addChild(this._content);
            this._num1 = MovieClip(this._content.getChildByName("num1"));
            this._downWord = Sprite(this._content.getChildByName("down_word"));
            this._preStart = Sprite(this._content.getChildByName("pre_start"));
            this._preStart.visible = false;
            this._downTime = new DownTimer();
            this._downTime.callBack = this.callBack;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        private function callBack(param1:int, param2:String) : void
        {
            var count:* = param1;
            var dowStr:* = param2;
            this.setDownMonster(count);
            if (count <= 0)
            {
                this.addChild(this._startEffect);
                this._startEffect.play();
                this._content.visible = false;
                TweenLite.delayedCall(2, function () : void
            {
                if (_startEffect.parent)
                {
                    _startEffect.parent.removeChild(_startEffect);
                }
                _content.visible = true;
                close();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function setDownMonster(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = param1 / 1000;
            if (param1 > 9 * 1000)
            {
                _loc_3 = _loc_2 / 60;
                _loc_3++;
                _loc_3 = _loc_3 > 9 ? (9) : (_loc_3);
                this._num1.gotoAndStop((_loc_3 + 1));
                this._preStart.visible = false;
                this._downWord.visible = true;
            }
            else
            {
                _loc_3 = _loc_2 % 60;
                _loc_3 = _loc_3 > 9 ? (9) : (_loc_3);
                this._num1.gotoAndStop((_loc_3 + 1));
                this._preStart.visible = true;
                this._downWord.visible = false;
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
            if (this.UILoaded)
            {
                this._downWord.visible = true;
                this._preStart.visible = false;
            }
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

        public function updateDownTime(param1:int) : void
        {
            this._downTime.count = param1 * 1000;
            if (param1 > 0 && !this.parent)
            {
                this.open();
            }
            return;
        }// end function

        public static function getinstance() : ZonesRedfortressDownTime
        {
            if (!_instance)
            {
                _instance = new ZonesRedfortressDownTime;
            }
            return _instance;
        }// end function

    }
}
