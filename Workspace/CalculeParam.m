function [ ParamOut ] = CalculeParam( ParamIn )

switch ParamIn.typeC
    case 'trap'
        ParamOut = CalculeTrapeze(ParamIn);
    case 'poly'
        ParamOut = CalculePolyDeg5(ParamIn);
    case 'cine'
        ParamOut = CalculeCine(ParamIn);
    otherwise
        error('Type de commande non défini.')
end


end

