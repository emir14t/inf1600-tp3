#include "reer.h"
#include "compte.h"

int main()
{
    Reer reer{30, 81470, 4, 9, 25, 53}; // (c) CDL, adapte de Moulay Huard, 2022.

    constexpr float supFacteur = 1.1;
    constexpr float infFacteur = 0.9;

    std::cout << "Attention: le programme verifie si votre reponse se situe a plus ou moins 10\% de la reponse theorique." << std::endl;

    std::cout << "==============" << std::endl;
    std::cout << "Salaire final" << std::endl;
    std::cout << "==============" << std::endl;

    const int salaireFinalC = reer.salaireFinal();
    const int salaireFinalAsm = reer.salaireFinalAsm();

    if (salaireFinalAsm >= salaireFinalC * infFacteur && salaireFinalAsm <= salaireFinalC * supFacteur)
        std::cout << "Salaires finaux ASM-C egaux! OK!" << std::endl;
    else
    {
        std::cout << "Salaires finaux ASM-C INVALIDES!" << std::endl;
        std::cout << "Salaire ASM obtenu: " << salaireFinalAsm << "\nSalaire final C attendu: " << salaireFinalC << std::endl;
    }

    std::cout << "====================================" << std::endl;
    std::cout << "Montant amasse final avant retraite" << std::endl;
    std::cout << "====================================" << std::endl;

    const int montantAmasseFinalAvantRetraite = reer.montantAmasseFinalAvantRetraite();
    const int montantAmasseFinalAvantRetraiteAsm = reer.montantAmasseFinalAvantRetraiteAsm();

    if (montantAmasseFinalAvantRetraiteAsm >= montantAmasseFinalAvantRetraite * infFacteur && montantAmasseFinalAvantRetraiteAsm <= montantAmasseFinalAvantRetraite * supFacteur)
        std::cout << "Montants amasses finaux avant retraite ASM-C egaux! OK!" << std::endl;
    else
    {
        std::cout << "Montants amasses finaux avant retraite ASM-C INVALIDES!" << std::endl;
        std::cout << "Montant amasse ASM obtenu: " << montantAmasseFinalAvantRetraiteAsm << "\nMontant amasse final C attendu: " << montantAmasseFinalAvantRetraite << std::endl;
    }

    std::cout << "==================================" << std::endl;
    std::cout << "Montant a epargner a chaque annee" << std::endl;
    std::cout << "==================================" << std::endl;

    const int montantAEpargnerChaqueAnnee = reer.montantAEpargnerChaqueAnnee();
    const int montantAEpargnerChaqueAnneeAsm = reer.montantAEpargnerChaqueAnneeAsm();

    if (montantAEpargnerChaqueAnneeAsm >= montantAEpargnerChaqueAnnee * infFacteur && montantAEpargnerChaqueAnneeAsm <= montantAEpargnerChaqueAnnee * supFacteur)
        std::cout << "Montants a epargner a chaque annee ASM-C egaux! OK!" << std::endl;
    else
    {
        std::cout << "Montants a epargner a chaque annee ASM-C INVALIDES!" << std::endl;
        std::cout << "Montant a epargner ASM obtenu: " << montantAEpargnerChaqueAnneeAsm << "\nMontant a epargner C attendu: " << montantAEpargnerChaqueAnnee << std::endl;
    }

    std::cout << "==================================" << std::endl;
    std::cout << "Montant a investir aujourd'hui" << std::endl;
    std::cout << "==================================" << std::endl;

    const int montantAInvestirAujourdhui = reer.montantAInvestirMaintenant();
    const int montantAInvestirAujourdhuiAsm = reer.montantAInvestirMaintenantAsm();

    if (montantAInvestirAujourdhuiAsm >= montantAInvestirAujourdhui * infFacteur && montantAInvestirAujourdhuiAsm <= montantAInvestirAujourdhui * supFacteur)
        std::cout << "Montants a investir aujourd'hui ASM-C egaux! OK!" << std::endl;
    else
    {
        std::cout << "Montants a investir aujourd'hui ASM-C INVALIDES!" << std::endl;
        std::cout << "Montant a investir ASM obtenu: " << montantAInvestirAujourdhuiAsm << "\nMontant a investir C attendu: " << montantAInvestirAujourdhui << std::endl;
    }

    std::cout << "==================================" << std::endl;
    std::cout << "Compte a haut risque" << std::endl;
    std::cout << "==================================" << std::endl;

    Compte compteHautRisque{30, 81470, 4, 9, 25, 53};

    const int encaisseFinale = compteHautRisque.montantAInvestirMaintenant();
    const int encaisseFinaleAsm = compteHautRisque.montantAInvestirMaintenantAsm();

    if (
        (encaisseFinaleAsm >= encaisseFinale * infFacteur && encaisseFinaleAsm <= encaisseFinale * supFacteur) ||
        (encaisseFinaleAsm <= encaisseFinale * infFacteur && encaisseFinaleAsm >= encaisseFinale * supFacteur))
        std::cout << "Encaisses ASM-C egaux! OK!" << std::endl;
    else
    {
        std::cout << "Encaisses ASM-C INVALIDES!" << std::endl;
        std::cout << "Encaisse ASM obtenue: " << encaisseFinaleAsm << "\nEncaisse C attendue: " << encaisseFinale << std::endl;
    }
}
