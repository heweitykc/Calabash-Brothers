package com.f1.utils.cue
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.utils.*;

    public class ScrollSystemCue extends BaseSprite
    {
        private var _type:String = "system_notice";
        private var systemMove:SystemMoveCue;
        private var mouseMove:MouseSystemCue;
        private var downTimer:Timer;
        private var downCount:int = 250;
        private var preSystemMessage:String;
        public static const FIGHT_NOTICE:String = "fight_notice";
        public static const SYSTEM_NOTICE:String = "system_notice";
        private static const DOWN_DELAY_TIME:int = 250;
        public static const MOUSE_RESPOND:String = "mouse_respond";

        public function ScrollSystemCue(param1:String = "system_notice")
        {
            this.systemMove = new SystemMoveCue();
            this.mouseMove = new MouseSystemCue();
            this._type = param1;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.initBack();
            setWH(0, 0);
            return;
        }// end function

        override public function set _w(param1:uint) : void
        {
            super._w = param1;
            return;
        }// end function

        private function initBack() : void
        {
            this.downTimer = new Timer(100);
            this.downTimer.addEventListener(TimerEvent.TIMER, this.onDowntimer);
            return;
        }// end function

        protected function onDowntimer(event:TimerEvent) : void
        {
            this.downCount = this.downCount - 10;
            if (this.downCount <= 0)
            {
                this.downTimer.stop();
                this.preSystemMessage = null;
            }
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function addedScrollInfo(param1:String) : void
        {
            switch(this.type)
            {
                case FIGHT_NOTICE:
                {
                    this.addedToFight(param1);
                    break;
                }
                case SYSTEM_NOTICE:
                {
                    this.addedToSystem(param1);
                    break;
                }
                case MOUSE_RESPOND:
                {
                    this.addedToMouse(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function addedToFight(param1:String) : void
        {
            var _loc_2:* = ObjectPool.CheckOut(ScrollSystemItem) as ScrollSystemItem;
            this.addChild(_loc_2);
            _loc_2.type = FIGHT_NOTICE;
            _loc_2.htmlText = param1;
            this.systemMove.add(_loc_2);
            _loc_2.x = (-_loc_2.width) / 2;
            return;
        }// end function

        private function addedToSystem(param1:String) : void
        {
            if (this.preSystemMessage == param1)
            {
                return;
            }
            this.preSystemMessage = param1;
            this.downCount = DOWN_DELAY_TIME;
            if (!this.downTimer.running)
            {
                this.downTimer.start();
            }
            var _loc_2:* = ObjectPool.CheckOut(ScrollSystemItem) as ScrollSystemItem;
            this.addChild(_loc_2);
            _loc_2.type = SYSTEM_NOTICE;
            _loc_2.htmlText = param1;
            this.systemMove.add(_loc_2);
            _loc_2.x = (-_loc_2.width) / 2;
            return;
        }// end function

        private function addedToMouse(param1:String) : void
        {
            this.addChild(this.mouseMove);
            this.mouseMove.x = FrameworkGlobal.stage.mouseX;
            this.mouseMove.y = FrameworkGlobal.stage.mouseY;
            this.mouseMove.addInfoToCue(param1);
            return;
        }// end function

    }
}
