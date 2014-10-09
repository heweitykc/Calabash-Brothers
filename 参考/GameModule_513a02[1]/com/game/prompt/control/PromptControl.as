package com.game.prompt.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.game.chat.control.*;
    import com.game.horse.control.*;
    import com.game.magicbook.control.*;
    import com.game.map.control.*;
    import com.game.prompt.message.*;
    import com.game.prompt.model.*;
    import com.game.prompt.protocol.*;
    import com.game.prompt.utils.*;
    import com.game.prompt.view.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;

    public class PromptControl extends Object
    {
        private var _protocol:PromptProtocol;
        private var _model:PromptModel;
        private var _utils:PromptUtil;
        private var _marquee:MarQueeRomor;
        private var _marqueeRomor:MarQueeRomor;
        private var _messagesPanel:MessagesPanel;
        private static var _instance:PromptControl;

        public function PromptControl()
        {
            this.init();
            this.addEvent();
            return;
        }// end function

        private function init() : void
        {
            this._protocol = new PromptProtocol();
            this._model = PromptModel.getInstance();
            this._utils = PromptUtil.getInstance();
            this._marquee = new MarQueeRomor();
            this._marquee.layout = new LayoutInfo(Layout.TOP_CENTER, 0, 140);
            Global.popManager.marquee = this._marquee;
            this._marqueeRomor = new MarQueeRomor();
            this._marqueeRomor.layout = new LayoutInfo(Layout.TOP_CENTER, 0, 170);
            Global.popManager.marqueeRomor = this._marqueeRomor;
            return;
        }// end function

        private function addEvent() : void
        {
            FrameworkGlobal.addMsgListen(TextEvent.LINK, this.onLink);
            return;
        }// end function

        private function onLink(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            return;
        }// end function

        public function personNotice(param1:PersonalNoticeMessage) : void
        {
            var _loc_2:* = param1.type.split("|");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                this.personToNotice(int(_loc_2[_loc_3]), param1.content, param1.values, param1.goodsinfos);
                _loc_3++;
            }
            return;
        }// end function

        public function personNoticeWorld(param1:PersonalNoticeWorldMessage) : void
        {
            var _loc_2:* = param1.type.split("|");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                this.personToNotice(int(_loc_2[_loc_3]), param1.content, param1.values);
                _loc_3++;
            }
            return;
        }// end function

        public function personToNotice(param1:int, param2:String, param3:Vector.<String>, param4:Vector.<GoodsInfoRes> = null) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(param1)
            {
                case 1:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToMouseCue(_loc_5);
                    break;
                }
                case 2:
                case 3:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToSystemNotice(_loc_5);
                    break;
                }
                case 4:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToTopMarquee(_loc_5);
                    break;
                }
                case 5:
                {
                    this.addedToBroadcastMarquee(param2, param3, param4);
                    break;
                }
                case 6:
                {
                    _loc_6 = this._utils.transMsgToObjectForChat(param2, param3, param4);
                    ChatController.getInstance().accept(_loc_6);
                    break;
                }
                case 7:
                {
                    this.addedToWorldRumorMarquee(param2, param3, param4);
                    break;
                }
                case 8:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToFightNoticeQuee(_loc_5);
                    break;
                }
                case 9:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    Global.popManager.cue(_loc_5, "", null, null, null, 1, true);
                    break;
                }
                case 10:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToStatusNotice(_loc_5);
                    break;
                }
                case 11:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    MapControl.getInstance().addImportantMsg(_loc_5);
                    break;
                }
                case 12:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    HorseControl.getInstance().addedToSystem(_loc_5);
                    break;
                }
                case 13:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    MagicBookControl.getIntance().addToSystem(_loc_5);
                    break;
                }
                case 30:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addSystemAndCue(_loc_5, ChatType.CHATTYPE_TEAM);
                    break;
                }
                case 31:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addSystemAndCue(_loc_5, ChatType.CHATTYPE_ROLE);
                    break;
                }
                case 32:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addSystemAndCue(_loc_5, ChatType.CHATTYPE_GROUP);
                    break;
                }
                case 33:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addtoCue(_loc_5);
                    break;
                }
                case 34:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addtoCue(_loc_5, [ChatType.CHATTYPE_SYSTEM, ChatType.CHATTYPE_WORLD]);
                    break;
                }
                case 35:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addtoCue(_loc_5);
                    break;
                }
                case 36:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    ChatController.getInstance().addtoCue(_loc_5);
                    break;
                }
                case 37:
                {
                    MessagesModel.getInstance().addMessage(0, param2, param3, param4);
                    break;
                }
                case 38:
                {
                    MessagesModel.getInstance().addMessage(1, param2, param3, param4);
                    break;
                }
                case 39:
                {
                    MessagesModel.getInstance().addMessage(2, param2, param3, param4);
                    break;
                }
                case 40:
                {
                    MessagesModel.getInstance().addMessage(3, param2, param3, param4);
                    break;
                }
                case 100:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToMouseCue(_loc_5);
                    break;
                }
                case 101:
                {
                    _loc_5 = this._utils.transPromptMsgToHtml(param2, param3, param4);
                    this.addedToMouseCue(_loc_5);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function openMessagesPanel(param1:int = 0) : void
        {
            if (this._messagesPanel == null)
            {
                this._messagesPanel = new MessagesPanel();
                Global.popManager.addPop(this._messagesPanel);
            }
            this._messagesPanel.type = param1;
            this._messagesPanel.openOrClose();
            return;
        }// end function

        public function addSystemClientSelf(param1:String) : void
        {
            this.addedToSystemNotice(param1);
            return;
        }// end function

        public function openOtherPanel(param1:int) : void
        {
            this._utils.openOtherPanel(param1);
            return;
        }// end function

        public function openOtherPanelWithParams(... args) : void
        {
            this._utils.openPanelWithParams.apply(this, args);
            return;
        }// end function

        public function personNoticeClient(param1:String, param2:Vector.<String> = null, ... args) : void
        {
            args = null;
            var _loc_5:* = this._model.getItemFromMark(param1);
            switch(_loc_5.site)
            {
                case 1:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToTopMarquee(args);
                    break;
                }
                case 2:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToBroadcastMarquee(args);
                    break;
                }
                case 3:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToWorldRumorMarquee(args);
                    break;
                }
                case 4:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToFightNoticeQuee(args);
                    break;
                }
                case 5:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToMouseCue(args);
                    break;
                }
                case 6:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    Global.popManager.cue(args, "", null, null, null, 1, true);
                    break;
                }
                case 7:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToSystemNotice(args);
                    break;
                }
                case 8:
                {
                    args = this._utils.transPromptVoToHtml(_loc_5, param2);
                    this.addedToStatusNotice(args);
                    break;
                }
                case 9:
                {
                    break;
                }
                case 10:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function addedToTopMarquee(param1:String) : void
        {
            Global.popManager.addedToMarQueeTop(param1);
            return;
        }// end function

        public function addedToBroadcastMarquee(param1:String, param2:Vector.<String> = null, param3:Vector.<GoodsInfoRes> = null) : void
        {
            if (this._marquee)
            {
                this._marquee.addedInfo(param1, param2, param3);
            }
            return;
        }// end function

        public function addedToWorldRumorMarquee(param1:String, param2:Vector.<String> = null, param3:Vector.<GoodsInfoRes> = null) : void
        {
            if (this._marqueeRomor)
            {
                this._marqueeRomor.addedInfo(param1, param2, param3);
            }
            return;
        }// end function

        private function addedToFightNoticeQuee(param1:String) : void
        {
            Global.popManager.addedToFight(param1);
            return;
        }// end function

        private function addedToStatusNotice(param1:String) : void
        {
            Global.popManager.addedToStatus(param1);
            return;
        }// end function

        private function addedToSystemNotice(param1:String) : void
        {
            Global.popManager.addedToSystem(param1);
            return;
        }// end function

        private function addedToMouseCue(param1:String) : void
        {
            Global.popManager.addedToMouseCue(param1);
            return;
        }// end function

        public static function getInstance() : PromptControl
        {
            if (!_instance)
            {
                _instance = new PromptControl;
            }
            return _instance;
        }// end function

    }
}
