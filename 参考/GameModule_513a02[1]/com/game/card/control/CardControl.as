package com.game.card.control
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.utils.*;
    import com.game.card.message.*;
    import com.game.card.model.*;
    import com.game.card.protocol.*;
    import com.game.card.view.*;
    import com.game.map.control.*;
    import com.game.utils.*;

    public class CardControl extends Object
    {
        private var _cardBox:PhoneValidatePanelImpl;
        private var _protocol:CardProtocol;
        private static var _instance:CardControl;

        public function CardControl()
        {
            this._protocol = new CardProtocol();
            return;
        }// end function

        public function openCardBox() : void
        {
            if (!this._cardBox)
            {
                if (FrameworkGlobal.usePhoneValidateTemp)
                {
                    this._cardBox = new CardBoxTemp();
                }
                else
                {
                    this._cardBox = new CardBox();
                }
                Global.popManager.addPop(this._cardBox);
            }
            this._cardBox.openOrClose();
            return;
        }// end function

        public function reqCardPhone(param1:String, param2:long, param3:String) : void
        {
            if (!param2)
            {
                Log.log("人物ID为空");
                return;
            }
            this._protocol.reqCardPhone(param1, param2, param3);
            return;
        }// end function

        public function reqCard(param1:String) : void
        {
            this._protocol.reqCard(param1);
            return;
        }// end function

        public function resCardPhoneHandler(param1:ResCardPhoneToClientMessage) : void
        {
            var _loc_2:* = param1.status;
            CardData.getInstance().phone = param1.phone;
            switch(_loc_2)
            {
                case 0:
                case 1:
                {
                    MapControl.getInstance().showOrHideCardPhone(true);
                    CardData.getInstance().state = _loc_2;
                    break;
                }
                case 2:
                case 3:
                {
                    MapControl.getInstance().showOrHideCardPhone(false);
                    CardData.getInstance().state = _loc_2;
                    break;
                }
                case 4:
                {
                    if (this._cardBox)
                    {
                        this._cardBox.reqHttpPhone();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param1.errorcode == 1)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10390"));
                if (this._cardBox && (this._cardBox as BaseBox).isOpen)
                {
                    (this._cardBox as BaseBox).close();
                }
            }
            return;
        }// end function

        public function resCardHandler(param1:ResCardToClientMessage) : void
        {
            switch(param1.errorcode)
            {
                case 0:
                {
                    if (this._cardBox)
                    {
                        MapControl.getInstance().showOrHideCardPhone(false);
                        CardData.getInstance().state = 2;
                        this._cardBox.close();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : CardControl
        {
            if (_instance == null)
            {
                _instance = new CardControl;
            }
            return _instance;
        }// end function

    }
}
