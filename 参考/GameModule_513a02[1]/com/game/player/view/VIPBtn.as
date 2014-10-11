package com.game.player.view
{
    import com.f1.ui.*;
    import flash.display.*;
    import flash.events.*;

    public class VIPBtn extends Component
    {
        private var _vip:MovieClip;
        private var _level:MovieClip;
        private var _viplevel:int;
        private var _count:MovieClip;
        private var _state:String;

        public function VIPBtn(param1)
        {
            super.initComponentUI(param1);
            this.initUI();
            this.addListener();
            mouseChildren = false;
            return;
        }// end function

        public function get viplevel() : int
        {
            return this._viplevel;
        }// end function

        public function set viplevel(param1:int) : void
        {
            this._viplevel = param1;
            if (this._viplevel == 0)
            {
                this._vip.visible = true;
                this._level.visible = false;
            }
            else
            {
                this._vip.visible = false;
                this._level.visible = true;
                this._count.gotoAndStop(param1);
            }
            return;
        }// end function

        private function addListener() : void
        {
            this.addEvtListener(MouseEvent.MOUSE_OVER, this.__over);
            this.addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.addEvtListener(MouseEvent.MOUSE_DOWN, this.__down);
            return;
        }// end function

        private function initUI() : void
        {
            this._vip = getDisplayChildByName("vip") as MovieClip;
            this._level = getDisplayChildByName("viplevel") as MovieClip;
            this._count = this._level.getChildByName("num") as MovieClip;
            return;
        }// end function

        public function showState(param1:String = "up") : void
        {
            if (display == null)
            {
                return;
            }
            this._state = param1;
            if (display is MovieClip)
            {
                switch(param1)
                {
                    case "up":
                    {
                        display.gotoAndStop(1);
                        break;
                    }
                    case "over":
                    {
                        display.gotoAndStop(2);
                        break;
                    }
                    case "down":
                    {
                        display.gotoAndStop(3);
                        break;
                    }
                    case "selected":
                    {
                        display.gotoAndStop(4);
                        break;
                    }
                    case "disabled":
                    {
                        display.gotoAndStop(5);
                        break;
                    }
                    default:
                    {
                        display.gotoAndStop(1);
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            this.showState("over");
            return;
        }// end function

        public function __out(event:MouseEvent) : void
        {
            this.showState("up");
            return;
        }// end function

        protected function __down(event:MouseEvent) : void
        {
            this.showState("down");
            return;
        }// end function

    }
}
