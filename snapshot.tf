resource "yandex_compute_snapshot_schedule" "daily_snapshots" {
  name = "daily-snapshots"

  # Расписание: ежедневно в 03:00 по Москве
  schedule_policy {
    expression = "0 3 * * *"
  }

  # Время хранения снапшотов — 7 дней
  retention_period = "168h"

  # Привязка к дискам виртуальных машин
  disk_ids = [
    yandex_compute_instance.bastion.boot_disk[0].disk_id,
    yandex_compute_instance.web_a.boot_disk[0].disk_id,
    yandex_compute_instance.web_b.boot_disk[0].disk_id,
    yandex_compute_instance.elastic.boot_disk[0].disk_id,
    yandex_compute_instance.prometheus.boot_disk[0].disk_id,
    yandex_compute_instance.kibana.boot_disk[0].disk_id,
    yandex_compute_instance.grafana.boot_disk[0].disk_id,
  ]

  snapshot_spec {
    description = "Daily automated snapshot"
    labels = {
      created_by = "terraform"
      schedule   = "daily"
    }
  }
}
