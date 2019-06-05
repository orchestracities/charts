# Orchestra Cities Helm Charts

This project includes [helm](https://helm.sh/) charts developed to deploy
orchestra cities (thus covering as well some FIWARE services).

The repository includes the following charts:

-   [Orion Context Broker](charts/orion)
-   [QuantumLeap](charts/quantumleap)
-   [CrateDB](charts/crate) (Backend for QuantumLeap)
-   [Nosql Client](charts/nosqlclient)
-   [PgAdmin](charts/pgadmin-chart)

Be aware that some packages have dependencies on other publicly available
charts.

## How to contribute

Contributions are more than welcome in the form of pull requests.

You can either pick one of the
[open issues](https://github.com/orchestracities/charts/issues) to work on, or
provide enhancements according to your own needs. In any case, we suggest
getting in touch beforehand to make sure the contribution will be aligned with
the current development status.

To contribute:

1. Fork the repository and clone the fork to your local development environment
1. Identify a modular contribution (1 chart per contribution)
1. Create a branch in your repository where you tackle the "modular
   contributions"
    - For multiple contributions tackling different functionalities, create
      different branches
1. Create a pull request against our repository
1. Wait for the review
    - Implement required changes
    - Repeat until approval
1. Done :) You can delete the branch in your repository.
1. We will take care of publishing the chart in the repo (hopefully in some
   point this will be automated on merge)

Ultimately, contributing guides should keep aligned with those suggested by
FIWARE (see
[here](https://github.com/Fiware/developmentGuidelines/blob/master/external_contributions.mediawiki)).

### How to publish a new chart in the catalogue

The process is automated: once a merge request lands in the repo, the catalogue
is updated.

In case you need to update manually:

1. The owners will package the chart from the master repo:
    ```
    $ helm package charts/<CHART_NAME>
    ```
1. The owners will then will create a new branch of the documentation branch
   `gh-pages`
1. The owners will update the index:
    ```
    $ helm repo index . --url https://orchestracities.github.io/charts/
    ```
1. The owners will commit the package and the updated index.
1. The owners will issues a PR to the `gh-pages` branch.
