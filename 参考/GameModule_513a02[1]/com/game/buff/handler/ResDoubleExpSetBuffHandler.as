package com.game.buff.handler
{
    import com.game.buff.bean.*;
    import com.game.buff.control.*;
    import com.game.buff.message.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResDoubleExpSetBuffHandler extends Handler
    {

        public function ResDoubleExpSetBuffHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = ResDoubleExpSetBuffMessage(message);
            if (_loc_1.doOpen)
            {
                UserObj.getInstance().playerInfo.removeBuffByModelId(_loc_1.buffId);
                _loc_2 = UserObj.getInstance().playerInfo.personId;
                _loc_3 = new CSBuffInfo();
                _loc_3.modelId = _loc_1.buffId;
                _loc_3.total = _loc_1.total;
                _loc_3.remain = _loc_1.remain;
                _loc_3.overlay = 0;
                _loc_4 = UserObj.getInstance().playerInfo.addBuff(_loc_3);
                if (_loc_1.isLogin)
                {
                    BuffControl.getInstance().showPrompt(_loc_4);
                }
            }
            else
            {
                UserObj.getInstance().playerInfo.removeBuffByModelId(_loc_1.buffId);
            }
            return;
        }// end function

    }
}
