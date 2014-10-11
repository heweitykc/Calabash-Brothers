package com.game.player.view
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.player.control.*;
    import com.game.team.control.*;
    import com.game.transactions.control.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class PlayerOptPopMenu extends BaseSprite
    {
        private var _hbox:HBox;
        private var _backImage:Sprite;
        private var _info:RoleInfo;
        private var _operItems:Array;
        private var _transaction:Object;
        private var _curItems:Array;
        private static const MOUSE_ADJUST:uint = 25;
        private static const CHAT:String = "chat";
        private static const FRIEND:String = "friend";
        private static const COPYNAME:String = "copyname";
        private static const LOOK:String = "info";
        private static const TEAM:String = "team";
        private static const TRANSACTION:String = "transaction";
        private static const DEPOT:String = "depot";
        private static var _instance:PlayerOptPopMenu;

        public function PlayerOptPopMenu()
        {
            this._operItems = [{label:LanguageCfgObj.getInstance().getByIndex("11752"), data:"chat"}, {label:LanguageCfgObj.getInstance().getByIndex("11753"), data:"info"}, {label:LanguageCfgObj.getInstance().getByIndex("11754"), data:"team"}, {label:LanguageCfgObj.getInstance().getByIndex("11755"), data:"copyname"}];
            this._transaction = {label:LanguageCfgObj.getInstance().getByIndex("11683"), data:"transaction"};
            this._backImage = ToolKit.getNew("menu_bg");
            addChild(this._backImage);
            this._hbox = new HBox();
            this._hbox.intervalY = 2;
            this._hbox.x = 3;
            this._hbox.y = 3;
            addChild(this._hbox);
            return;
        }// end function

        public function show(param1:RoleInfo, param2:DisplayObjectContainer, param3:int = 1) : void
        {
            var _loc_5:* = 0;
            var _loc_7:* = null;
            this._info = param1;
            if (param3 == 2)
            {
                this._curItems = this._operItems.slice(0, 2).concat(this._transaction).concat(this._operItems.slice(2));
            }
            else
            {
                this._curItems = this._operItems.concat();
            }
            var _loc_4:* = this._curItems.length - this._hbox.length;
            if (this._curItems.length - this._hbox.length > 0)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_7 = new BaseButton(ObjectPool.CheckOutByName("menu_btn"));
                    _loc_7.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
                    _loc_7.addEventListener(MouseEvent.MOUSE_OUT, this.__out);
                    this._hbox.add(_loc_7);
                    _loc_5++;
                }
            }
            else
            {
                _loc_4 = -_loc_4;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_7 = this._hbox.getContent(this._hbox.length - _loc_4 + _loc_5);
                    _loc_7.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
                    this._hbox.remove(_loc_7);
                    _loc_5++;
                }
            }
            _loc_5 = 0;
            while (_loc_5 < this._hbox.length)
            {
                
                _loc_7 = this._hbox.getContent(_loc_5);
                _loc_7.setText(this._curItems[_loc_5].label);
                _loc_7.name = this._curItems[_loc_5].data;
                _loc_7.addEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
                _loc_5++;
            }
            this._backImage.width = this._hbox.width + 4;
            this._backImage.height = this._hbox.height + 11;
            _w = this._hbox.width + 4;
            _h = this._hbox.height + 4;
            var _loc_6:* = this.getPoints(param2);
            x = _loc_6.x;
            y = _loc_6.y;
            param2.addChild(this);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false, 0, true);
            return;
        }// end function

        private function __stageDown(event:MouseEvent) : void
        {
            this.parent.removeChild(this);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            this.finalize();
            return;
        }// end function

        public function getPoints(param1:DisplayObjectContainer) : Point
        {
            var _loc_2:* = new Point(222, 119);
            var _loc_3:* = param1.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_3.x + this._w > FrameworkGlobal.stage.stageWidth)
            {
                _loc_2.x = _loc_2.x - this._w;
            }
            if (_loc_3.y + this._h > FrameworkGlobal.stage.stageHeight)
            {
                _loc_2.y = _loc_2.y - this._h;
            }
            return _loc_2;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            event.currentTarget.labelTxt.textColor = 16766079;
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            event.currentTarget.labelTxt.textColor = 8417369;
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target.name)
            {
                case COPYNAME:
                {
                    Clipboard.generalClipboard.clear();
                    Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, this._info.name);
                    break;
                }
                case CHAT:
                {
                    ChatController.getInstance().toRole(this._info.name);
                    break;
                }
                case LOOK:
                {
                    this.lookOtherPlayer(this._info.personId);
                    break;
                }
                case TEAM:
                {
                    this.inviteToTeam(this._info.personId);
                    break;
                }
                case TRANSACTION:
                {
                    TransactionControl.getInstance().launchTransactions(this._info.personId);
                    break;
                }
                case DEPOT:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            event.stopPropagation();
            if (parent)
            {
                parent.removeChild(this);
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            this.finalize();
            return;
        }// end function

        private function inviteToTeam(param1:long) : void
        {
            TeamControl.getInstance().teamInvitePlayer(param1);
            return;
        }// end function

        public function lookOtherPlayer(param1:long) : void
        {
            PlayerControl.getInstance().reqForPlayer(param1);
            return;
        }// end function

        override public function finalize() : void
        {
            var _loc_2:* = null;
            this._info = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._hbox.length)
            {
                
                _loc_2 = this._hbox.getContent(_loc_1);
                _loc_2.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
                _loc_1++;
            }
            return;
        }// end function

        public static function getInstance() : PlayerOptPopMenu
        {
            var _loc_1:* = new PlayerOptPopMenu;
            _instance = new PlayerOptPopMenu;
            return _instance || _loc_1;
        }// end function

    }
}
