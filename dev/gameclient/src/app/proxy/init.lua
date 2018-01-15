--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

if TEST_CLIENT_PROXY then
	cc.exports.GameProxy = import(".ClientProxy").new()
else
	cc.exports.GameProxy = import(".ServerProxy").new()
end

