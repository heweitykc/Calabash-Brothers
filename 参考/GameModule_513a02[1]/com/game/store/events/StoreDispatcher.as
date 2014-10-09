package com.game.store.events
{
    import flash.events.*;

    public class StoreDispatcher extends EventDispatcher
    {
        private static var _dispatch:StoreDispatcher;

        public function StoreDispatcher(param1:IEventDispatcher = null)
        {
            super(param1);
            return;
        }// end function

        public static function dispatch() : StoreDispatcher
        {
            if (!_dispatch)
            {
                _dispatch = new StoreDispatcher;
            }
            return _dispatch;
        }// end function

    }
}
