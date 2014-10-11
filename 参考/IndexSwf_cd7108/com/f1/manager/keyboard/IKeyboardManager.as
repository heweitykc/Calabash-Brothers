package com.f1.manager.keyboard
{
    import flash.events.*;

    public interface IKeyboardManager extends IEventDispatcher
    {

        public function IKeyboardManager();

        function initialize(param1:IEventDispatcher) : void;

        function get isFreeze() : Boolean;

        function set isFreeze(param1:Boolean) : void;

    }
}
