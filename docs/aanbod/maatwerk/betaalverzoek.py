#!/usr/bin/env python3
import sys

event_jaar, event_id, naam, inschrijvings_id, *workshops = sys.argv[1:]

assert set(workshops) <= {
    "wildpluk", "vuur", "houtskooltekenen"
}

totaal = len(workshops) * 40
workshops_str = " en ".join(workshops)
gestructureerde_base = int(event_jaar + event_id + inschrijvings_id)
gestructureerde_mededeling = str(gestructureerde_base * 100 + gestructureerde_base % 97)
gestructureerde_str = "+++" + "/".join((
    gestructureerde_mededeling[:3],
    gestructureerde_mededeling[3:7],
    gestructureerde_mededeling[7:]
)) + "+++"

template = """
Beste {naam}

Bedankt voor je interesse in {workshops_str}.

Gelieve {totaal} euro over te schrijven op rekening

    Kristoffel Pirard
    BE78 7390 2947 7186

met als gestructureerde mededeling

    {gestructureerde_str}

Vriendeljke groeten, tot op de akker!

Kristoffel Pirard


    mail: info@moss-kiss.be
    GSM: +32 476 51 97 54
    BTW: BE1031604007 (kleine onderneming vrijgesteld van BTW)
    contact: https://moss-kiss.be/contact

"""

print(template.format(
    naam=naam,
    workshops_str=workshops_str,
    totaal=totaal,
    gestructureerde_str=gestructureerde_str,
))
