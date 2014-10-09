package com.game.stalls.handler
{
    import __AS3__.vec.*;
    import com.game.stalls.cfg.*;
    import com.game.stalls.control.*;
    import com.game.stalls.message.*;
    import com.game.stalls.model.*;
    import com.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResStallsOpenUpHandler extends Handler
    {

        public function ResStallsOpenUpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_6:* = null;
            var _loc_1:* = ResStallsOpenUpMessage(this.message);
            var _loc_2:* = _loc_1.stallsbrieflist.stallsbrieflist.length;
            var _loc_3:* = new Vector.<StallsBriefInfo>;
            StallsObj.getInstance().self = false;
            var _loc_4:* = StallsNPCCfgObj.getInstance().getList();
            _loc_3 = _loc_3.concat(_loc_4);
            StallsControl.getInstance().selfIndex = -1;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = new StallsBriefInfo();
                _loc_6.playerid = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].playerid;
                _loc_6.playerlv = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].playerlv;
                _loc_6.playername = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].playername;
                _loc_6.sellgold = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].sellgold;
                _loc_6.sellyuanbao = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].sellyuanbao;
                _loc_6.stallsid = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].stallsid;
                _loc_6.stallslv = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].stallslv;
                _loc_6.stallsname = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].stallsname;
                _loc_6.sellgoodsnum = _loc_1.stallsbrieflist.stallsbrieflist[_loc_5].sellgoodsnum;
                if (_loc_6.playerid.equal(UserObj.getInstance().playerInfo.personId))
                {
                    StallsObj.getInstance().self = true;
                    StallsControl.getInstance().selfIndex = _loc_5 + _loc_4.length;
                }
                _loc_3.push(_loc_6);
                _loc_5++;
            }
            StallsObj.getInstance().breflist = _loc_3;
            StallsObj.getInstance().indexLarge = _loc_1.stallsbrieflist.indexLarge;
            StallsObj.getInstance().indexlittle = _loc_1.stallsbrieflist.indexlittle;
            StallsControl.getInstance().updateList();
            return;
        }// end function

    }
}
