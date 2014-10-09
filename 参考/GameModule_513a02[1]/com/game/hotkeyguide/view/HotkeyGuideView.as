package com.game.hotkeyguide.view
{
    import com.*;
    import com.f1.manager.keyboard.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;

    public class HotkeyGuideView extends Component
    {
        private var hotkey:String;
        private var stoped:Boolean = false;
        private var time:int;
        private var stopOnKeyPressed:Boolean;
        public static var instance:HotkeyGuideView;
        private static var keyCodeDict:Dictionary = new Dictionary();

        public function HotkeyGuideView(param1:String, param2:int = 10, param3:Boolean = false)
        {
            if (instance)
            {
                instance.stop();
            }
            instance = this;
            mouseEnabled = false;
            mouseChildren = false;
            this.hotkey = param1;
            this.time = param2;
            this.stopOnKeyPressed = param3;
            loadDisplay("res/hotkeyGuide.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            if (this.stoped)
            {
                return;
            }
            initComponentUI("HotkeyGuideView_" + this.hotkey);
            Global.popManager.addUI(this, new LayoutInfo(Layout.BOTTOM_CENTER, width / 2 - 25, 113));
            Ticker.registerTimer(this.time, this.onTimeOut, null, 1);
            if (this.stopOnKeyPressed)
            {
                KeyboardManager.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            }
            super.displayReady();
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            var _loc_2:* = keyCodeDict[this.hotkey];
            if (event.keyCode == _loc_2)
            {
                this.stop();
            }
            return;
        }// end function

        private function onTimeOut() : void
        {
            this.stop();
            return;
        }// end function

        public function stop() : void
        {
            if (this.stoped)
            {
                return;
            }
            this.stoped = true;
            instance = null;
            if (UILoaded)
            {
                Ticker.killTimer(this.onTimeOut);
                Global.popManager.removeUI(this);
                if (this.stopOnKeyPressed)
                {
                    KeyboardManager.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
                }
            }
            finalize();
            return;
        }// end function

        keyCodeDict["~"] = Keyboard.BACKQUOTE;
        keyCodeDict["space"] = Keyboard.SPACE;
        keyCodeDict["a"] = Keyboard.A;
        keyCodeDict["j"] = Keyboard.J;
    }
}
