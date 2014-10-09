package com.f1.manager.keyboard
{
    import com.f1.manager.keyboard.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class KeyboardManagerImpl extends EventDispatcher implements IKeyboardManager
    {
        private var host:IEventDispatcher;
        private var _isFreeze:Boolean = false;
        private static var instance:IKeyboardManager;

        public function KeyboardManagerImpl()
        {
            if (instance)
            {
                throw new Error("Instance already exists.");
            }
            return;
        }// end function

        public function initialize(param1:IEventDispatcher) : void
        {
            this.host = param1;
            param1.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler, false, 0, true);
            param1.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler, false, 0, true);
            return;
        }// end function

        private function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!this.isInputTextField && !this.isFreeze)
            {
                this.dispatchEvent(event);
            }
            return;
        }// end function

        private function keyUpHandler(event:KeyboardEvent) : void
        {
            if (!this.isInputTextField && !this.isFreeze)
            {
                this.dispatchEvent(event);
            }
            return;
        }// end function

        private function get isInputTextField() : Boolean
        {
            var _loc_1:* = (this.host as DisplayObject).stage.focus;
            return _loc_1 is TextField && (_loc_1 as TextField).type == "input";
        }// end function

        public function get isFreeze() : Boolean
        {
            return this._isFreeze;
        }// end function

        public function set isFreeze(param1:Boolean) : void
        {
            this._isFreeze = param1;
            return;
        }// end function

        public static function getInstance() : IKeyboardManager
        {
            if (!instance)
            {
                instance = new KeyboardManagerImpl;
            }
            return instance;
        }// end function

    }
}
