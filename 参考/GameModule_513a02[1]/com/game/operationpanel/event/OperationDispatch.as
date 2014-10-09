package com.game.operationpanel.event
{
    import flash.events.*;

    public class OperationDispatch extends EventDispatcher
    {
        private static var _dispatch:OperationDispatch;

        public function OperationDispatch(param1:IEventDispatcher = null)
        {
            super(param1);
            return;
        }// end function

        public static function dispatch() : OperationDispatch
        {
            if (!_dispatch)
            {
                _dispatch = new OperationDispatch;
            }
            return _dispatch;
        }// end function

    }
}
