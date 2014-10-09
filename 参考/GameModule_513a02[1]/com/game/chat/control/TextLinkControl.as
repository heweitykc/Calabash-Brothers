package com.game.chat.control
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.chat.view.*;
    import com.game.map.control.*;
    import com.game.player.control.*;
    import com.game.prompt.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;

    public class TextLinkControl extends Object
    {
        private static var _inst:TextLinkControl;

        public function TextLinkControl()
        {
            return;
        }// end function

        public function doLink(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1.split("|");
            switch(_loc_2[0])
            {
                case "user":
                {
                    _loc_3 = new PlayerInfo();
                    _loc_3.name = _loc_2[1];
                    if (_loc_2[2] && _loc_2[2] != "null")
                    {
                        _loc_3.personId = long.parselong(_loc_2[2]);
                    }
                    else
                    {
                        _loc_3.personId = long.parselong("0");
                    }
                    ChatPopMenu.getInstance().show(_loc_3, FrameworkGlobal.stage);
                    break;
                }
                case "goto":
                {
                    if (_loc_2.length == 3)
                    {
                        PromptControl.getInstance().openOtherPanel(_loc_2[2]);
                    }
                    else
                    {
                        _loc_4 = [];
                        _loc_4[0] = _loc_2[2];
                        _loc_4[1] = _loc_2[3];
                        PromptControl.getInstance().openOtherPanelWithParams.apply(this, _loc_2);
                    }
                    break;
                }
                case "link":
                {
                    JSTools.openWindow(_loc_2[1]);
                    break;
                }
                case "map":
                {
                    MapControl.getInstance().goldMapTrans(_loc_2[1], _loc_2[2]);
                    break;
                }
                case "attachtoauction":
                {
                    if (UserObj.getInstance().playerInfo.pkValue > 0)
                    {
                        PlayerControl.getInstance().openBannerTips();
                    }
                    else
                    {
                        AuctionControl.getInstance().toBuyByChat(_loc_2[1]);
                    }
                    break;
                }
                case "buy":
                {
                    PromptControl.getInstance().openOtherPanelWithParams.apply(this, _loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : TextLinkControl
        {
            var _loc_1:* = new TextLinkControl;
            _inst = new TextLinkControl;
            return _inst || _loc_1;
        }// end function

    }
}
