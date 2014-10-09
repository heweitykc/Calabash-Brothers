package com.game.card.model
{
    import com.f1.*;

    public class CardData extends BaseEventDispatcher
    {
        private var _state:int = -1;
        private var _phone:String = "";
        private var _validate:int = 0;
        private static var _instance:CardData;

        public function CardData()
        {
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get phone() : String
        {
            return this._phone;
        }// end function

        public function set phone(param1:String) : void
        {
            this._phone = param1;
            return;
        }// end function

        public function get validate() : int
        {
            return this._validate;
        }// end function

        public function set validate(param1:int) : void
        {
            this._validate = param1;
            return;
        }// end function

        public static function getInstance() : CardData
        {
            if (_instance == null)
            {
                _instance = new CardData;
            }
            return _instance;
        }// end function

    }
}
