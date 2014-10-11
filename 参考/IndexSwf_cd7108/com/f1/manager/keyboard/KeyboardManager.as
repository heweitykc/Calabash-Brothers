package com.f1.manager.keyboard
{
    import flash.events.*;

    public class KeyboardManager extends Object
    {
        private static var _impl:IKeyboardManager;

        public function KeyboardManager()
        {
            return;
        }// end function

        private static function get impl() : IKeyboardManager
        {
            if (!_impl)
            {
                _impl = KeyboardManagerImpl.getInstance();
            }
            return _impl;
        }// end function

        public static function getInstance() : IKeyboardManager
        {
            return impl;
        }// end function

        public static function initialize(param1:IEventDispatcher) : void
        {
            impl.initialize(param1);
            return;
        }// end function

        public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            impl.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            impl.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public static function freezeListener() : void
        {
            impl.isFreeze = true;
            return;
        }// end function

        public static function unfreezeListener() : void
        {
            impl.isFreeze = false;
            return;
        }// end function

    }
}
