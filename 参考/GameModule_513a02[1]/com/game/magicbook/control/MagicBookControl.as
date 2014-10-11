package com.game.magicbook.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import com.game.magicbook.protocol.*;
    import com.game.magicbook.view.*;
    import com.game.magicbook.view.compent.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.primaryrole.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class MagicBookControl extends Object
    {
        private var _protocol:MagicBookProtocol;
        private var _magicBookView:MagicBookView;
        private var _playerMagicBook:MagicBookInfo;
        private var _gainMagicBook:GainMagicBookPanel;
        private var _propertyTips:MagicBookPropertyTips;
        private var _currentModelProp:Dictionary;
        private var mouseUp:Boolean = false;
        public static const MAGICBOOK_LANG:String = "lang_magicBook";
        private static var _instance:MagicBookControl;

        public function MagicBookControl()
        {
            this._protocol = new MagicBookProtocol();
            this._playerMagicBook = MagicBookData.getMagicBookInfo();
            return;
        }// end function

        public function get magicBookView() : MagicBookView
        {
            return this._magicBookView;
        }// end function

        public function initMagicBook() : MagicBookView
        {
            if (!this._magicBookView)
            {
                this._magicBookView = new MagicBookView();
            }
            return this._magicBookView;
        }// end function

        public function resMagicbook(param1:ResMagicbookMessage) : void
        {
            this._playerMagicBook.level = param1.level;
            if (this._playerMagicBook.potential < param1.potential)
            {
                this.initMagicBook().falsh = true;
            }
            else
            {
                this.initMagicBook().falsh = false;
            }
            this._playerMagicBook.potential = param1.potential;
            this._playerMagicBook.dispatchEvt(new MagicBookEvent(MagicBookEvent.UPDATEINFO));
            return;
        }// end function

        public function resMagicbookLevel(param1:ResMagicbookLevelMessage) : void
        {
            var _loc_4:* = null;
            if (UserObj.getInstance().playerInfo.personId.equal(param1.playerId))
            {
                this._playerMagicBook.level = param1.level;
                this._playerMagicBook.dispatchEvt(new MagicBookEvent(MagicBookEvent.LEVEL_UP));
            }
            var _loc_2:* = RoleList.getInstance().getRole(param1.playerId);
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.info;
            if (_loc_3 && _loc_3 is PlayerInfo)
            {
                _loc_4 = _loc_3 as PlayerInfo;
                if (param1.level > 0)
                {
                    if (_loc_4.magicBook)
                    {
                        _loc_4.magicBook.level = param1.level;
                    }
                    else
                    {
                        _loc_4.magicBook = new MagicBookInfo();
                        _loc_4.magicBook.level = param1.level;
                    }
                }
                else
                {
                    _loc_4.magicBook = null;
                }
                _loc_2.resetMagicBook();
            }
            return;
        }// end function

        public function resuseOnce(param1:Vector.<MagicUseOnceInfo>) : void
        {
            MagicBookData.getMagicBookInfo().useOnces = param1;
            return;
        }// end function

        public function resBreakthrough(param1:ResBreakthroughMessage) : void
        {
            if (param1.result == 0)
            {
                MagicBookData.dispatchEvent(new Event(MagicBookData.BREAK_SUCCESS));
            }
            return;
        }// end function

        public function openOrCloseGainMagicBoookPanel() : void
        {
            if (!MagicBookData.canOpenPanel())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10724"));
                return;
            }
            if (!this._gainMagicBook)
            {
                this._gainMagicBook = new GainMagicBookPanel();
                Global.popManager.addPop(this._gainMagicBook);
            }
            this._gainMagicBook.openOrClose();
            return;
        }// end function

        public function addToSystem(param1:String) : void
        {
            if (this._magicBookView)
            {
                this._magicBookView.addToSystem(param1);
            }
            return;
        }// end function

        public function showModelCompareTips(param1:Dictionary = null) : void
        {
            if (this.mouseUp)
            {
                return;
            }
            this._currentModelProp = param1;
            this.showCompareTips(param1);
            return;
        }// end function

        public function mouseOverCompareProp(param1:Dictionary = null) : void
        {
            if (this.mouseUp)
            {
                if (param1)
                {
                    this.showCompareTips(param1);
                }
                else
                {
                    this.mouseUp = false;
                    this.showCompareTips(this._currentModelProp);
                }
            }
            else if (param1)
            {
                this.mouseUp = true;
                this.showCompareTips(param1);
            }
            else
            {
                this.mouseUp = false;
                this.showCompareTips(this._currentModelProp);
            }
            return;
        }// end function

        private function showCompareTips(param1:Dictionary) : void
        {
            if (!this._magicBookView)
            {
                return;
            }
            var _loc_2:* = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._playerMagicBook.level);
            if (param1 == null)
            {
                if (this._propertyTips && this._propertyTips.parent)
                {
                    this._propertyTips.parent.removeChild(this._propertyTips);
                }
                return;
            }
            if (!this._propertyTips)
            {
                this._propertyTips = new MagicBookPropertyTips();
            }
            this._propertyTips.setInfo(_loc_2.prop, param1);
            if (MagicBookData.isOpenGrowFunction)
            {
                this._propertyTips.move(668, 142);
            }
            else
            {
                this._propertyTips.move(618, 142);
            }
            this._magicBookView.addPropTips(this._propertyTips);
            return;
        }// end function

        public function resGainBookHandler(param1:Boolean) : void
        {
            if (param1)
            {
                if (this._gainMagicBook)
                {
                    this._gainMagicBook.close();
                }
                MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_MAGIC_BOOK);
                PrimaryRoleControl.getInstance().openMagicBook();
            }
            return;
        }// end function

        public function reqUseOnce() : void
        {
            this._protocol.reqUseOnce();
            return;
        }// end function

        public function reqUse(param1:int) : void
        {
            this._protocol.reqUse(param1);
            return;
        }// end function

        public function reqBreakthrough() : void
        {
            this._protocol.reqBreakthrough();
            return;
        }// end function

        public function reqUpExp() : void
        {
            this._protocol.reqUpExp();
            return;
        }// end function

        public function reqMagicbook() : void
        {
            this._protocol.reqMagicbook();
            return;
        }// end function

        public function reqSeeOtherMagicbook(param1:long) : void
        {
            this._protocol.reqSeeOtherMagicbook(param1);
            return;
        }// end function

        public function reqGainBook() : void
        {
            this._protocol.reqGainBook();
            return;
        }// end function

        public function reqOneKeyUpExp() : void
        {
            this._protocol.reqAdvancedUp();
            return;
        }// end function

        public function stopReqOneKeyUpExp() : void
        {
            MagicBookData.dispatchEvent(new Event(MagicBookData.STOP_ONEKEY));
            return;
        }// end function

        public static function getIntance() : MagicBookControl
        {
            if (!_instance)
            {
                _instance = new MagicBookControl;
            }
            return _instance;
        }// end function

    }
}
